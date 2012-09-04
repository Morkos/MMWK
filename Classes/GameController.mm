//
//  DragonEyeViewController.m
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GameController.h"
#import "Loggers.h"
#import "LevelLoader.h"
#import "LevelEnum.h"
#import "FreezeModeManager.h"

static Program * program = [Program getProgram];

//TODO: very bad...global variable
NSUInteger gblTicks;

@implementation GameController

@synthesize animating, context, displayLink;

+ (void) setupObjectsInWorld {
    SpriteSheetManager *spriteSheetManager = [SpriteSheetManager getInstance];
    [spriteSheetManager loadFromFile:[[NSBundle mainBundle] 
                                      pathForResource:@"spriteSheets"
                                      ofType:@"json"
                                      ]];
    NSLog(@"Loading the first level.");
    
	LevelLoader * loader = [LevelLoader getInstance];
	[loader loadLevel:LEVEL1];
}

- (void)awakeFromNib {
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext) {
		// TODO: Throw an error, GLES1 not supported
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext) {
        NSLog(@"Failed to create ES context");
	}
    else if (![EAGLContext setCurrentContext:aContext]) {
        NSLog(@"Failed to set ES context current");
	}
    
    self.context = aContext;
    [aContext release];
    
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2) {
        [self loadShaders];
	}
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
	
	[GameController setupObjectsInWorld];
}

- (void)dealloc
{
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startGame];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopGame];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Tear down context.
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
	}
    self.context = nil; 
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
     Frame interval defines how many display frames must pass between each time the display link fires.
     The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. 
     The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. 
     A frame interval setting of less than one results in undefined behavior.
     */
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        if (animating) {
            [self stopGame];
            [self startGame];
        }
    }
}

- (void) startGame
{
	DLOG("calling start game...");
    if (!animating) {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self 
																		  selector:@selector(gameLoop)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
						   forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void) stopGame
{
    if (animating) {
	  [self.displayLink invalidate];
	  self.displayLink = nil;
	  animating = FALSE;
    }
}


- (void)touchesMoved:(NSSet *)touches 
           withEvent:(UIEvent *)event {
    
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.view];
	
	DLOG(@"Point touched %.2f, %.2f", point.x, point.y);
	
	GLint screenWidth = ((EAGLView *)self.view).framebufferWidth;
	GLint screenHeight = ((EAGLView *)self.view).framebufferHeight;
	CGSize screenSize = CGSizeMake(screenWidth, screenHeight);
	CGPoint glPoint = [GraphicsEngine convertScreenPointToGl:point
                                                  screenSize:screenSize];
	
    [[FreezeModeManager getInstance] processNodesTouches:glPoint];
   
}

- (void) touchesEnded:(NSSet *)touches 
            withEvent:(UIEvent *)event {
    
    //TODO: can user lift finger while all nodes have not been touched?
    
}

- (void) gameLoop {
	
    [(EAGLView *)self.view setFramebuffer];
    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
 
    // Use shader program.
    glUseProgram(program.programId);
    
    // Animate and draw all objects
	for (id<Drawable,Collidable> obj in [ObjectContainer singleton].objArray) {
		
		gblTicks++;

		[obj update];
		
		if ([obj conformsToProtocol:@protocol(Collidable)]) {
			[obj resolveCollisions];
		}
		
		[GraphicsEngine initializeProperties];
		[obj draw];
	}
    
    [[Camera getInstance] update];

    // Validate program before drawing. This is a good check, but only really necessary in a debug build.
    // DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
    if (![program validateProgram])
    {
        DLOG(@"Failed to validate program: %d", program.programId);
        return;
    }
#endif
    
    [(EAGLView *)self.view presentFramebuffer];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (BOOL)loadShaders
{   
    // Create shader program.
    [program createProgram];
	GLuint programId = program.programId;
    
    // Create and compile vertex shader.
    NSString *vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    Shader *vertShader = [[ShaderManager getInstance] getShader:vertShaderPathname];
    if (!vertShader)
    {
        DLOG("Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    NSString *fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    Shader *fragShader = [[ShaderManager getInstance] getShader:fragShaderPathname];
    if (!fragShader)
    {
        DLOG("Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(programId, vertShader.shaderId);
    
    // Attach fragment shader to program.
    glAttachShader(programId, fragShader.shaderId);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(programId, ATTRIB_VERTEX, "position");
    glBindAttribLocation(programId, ATTRIB_TEXTURE, "texture_coord");
    
    // Link program.
    if (![program linkProgram]) {
        DLOG("Failed to link program: %d", programId);
        
        [vertShader dealloc];
        [fragShader dealloc];
        
        @throw([NSException exceptionWithName:@"ProgramLink" reason:@"Link error" userInfo:nil]);
    }
    
    // Get uniform locations.
	ShaderConstants::uniforms[UNIFORM_OPACITY] = glGetUniformLocation(programId, "opacity");
	ShaderConstants::uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(programId, "translate");
	ShaderConstants::uniforms[UNIFORM_SCALE] = glGetUniformLocation(programId, "scale");
	ShaderConstants::uniforms[UNIFORM_ROTATE] = glGetUniformLocation(programId, "angle");
	
    
    // Set vertex and fragment shaders up for deletion when glDetachShader gets called.
    [vertShader dealloc];
    [fragShader dealloc];
    
    return TRUE;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
		    || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
