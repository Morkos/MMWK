//
//  DragonEyeViewController.m
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GameController.h"

static Program * program = [Program getProgram];
static Node *node = nil;

@implementation GameController

@synthesize animating, context, displayLink;

+ (void) setupObjectsInWorld {
	
	//TODO: Move to separate game initialization code
	Texture *texture1 = [Texture textureWithFilename:[[NSBundle mainBundle] 
								     pathForResource:@"lancelotSpSheet" 
											  ofType:@"png"]];
	
	Texture *overlayTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
										   pathForResource:@"node" 
												    ofType:@"png"]];
	
	Texture *backgroundTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
															   pathForResource:@"background" 
															   ofType:@"png"]];
	
	Texture *slashTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
														  pathForResource:@"slash" 
														  ofType:@"png"]];
	
	SpriteSheet *overlaySprite = 
		[SpriteSheet createWithTexture:overlayTexture  
							 numOfRows:1
							   columns:[NSArray arrayWithObjects:
										     [NSNumber numberWithInt:1],
											 nil
									   ]
		];
	
	SpriteSheet *sprite = 
		[SpriteSheet createWithTexture:texture1 
							 numOfRows:5
							   columns:[NSArray arrayWithObjects:
											 [NSNumber numberWithInt:1],
											 [NSNumber numberWithInt:4],
											 [NSNumber numberWithInt:3],
											 [NSNumber numberWithInt:7],
											 [NSNumber numberWithInt:4],
											 nil
									   ]
		];
	
	// Particle effects
	// TODO: Use configuration file
	ParticleEffectsManager *effectsManager = [ParticleEffectsManager manager:10];
	
	BezierCurve *pathAttack0 = [BezierCurve curveFrom:CGPointMake(0.4, 0.2)
											c0:CGPointMake(0.5, 0.1) 
											c1:CGPointMake(0.5, 0.05) 
										    to:CGPointMake(0.4, 0.0) 
								   numOfPoints:50];
	
	SlashingParticleEffect *attackEffect0 = 
			[SlashingParticleEffect createEffect:pathAttack0 
										   speed:5 
									particleSize:CGSizeMake(0.025f, 0.025f)
									  startAngle:0.5f
										endAngle:2.0f
								   opacityFactor:1.15f
								   frameInterval:1
										   image:slashTexture];
	
	BezierCurve *pathAttack1 = [BezierCurve curveFrom:CGPointMake(0.4, 0.2)
												   c0:CGPointMake(0.5, 0.1) 
												   c1:CGPointMake(0.5, -0.2) 
												   to:CGPointMake(0.4, -0.4) 
										  numOfPoints:50];
	
	SlashingParticleEffect *attackEffect1 = 
			[SlashingParticleEffect createEffect:pathAttack1 
										   speed:5 
									particleSize:CGSizeMake(0.025f, 0.025f)
									  startAngle:0.5f
										endAngle:2.0f
								   opacityFactor:1.15f
								   frameInterval:1
										   image:slashTexture];
	
	BezierCurve *pathAttack2 = [BezierCurve curveFrom:CGPointMake(0.4, 0.1)
												   c0:CGPointMake(0.2, 0.05) 
												   c1:CGPointMake(0.1, 0.02)
												   to:CGPointMake(0.0, 0.0)
										  numOfPoints:50];
	
	SlashingParticleEffect *attackEffect2 = 
			[SlashingParticleEffect createEffect:pathAttack2 
										   speed:5 
									particleSize:CGSizeMake(0.025f, 0.025f)
									  startAngle:0.5f
										endAngle:2.0f
								   opacityFactor:1.15f
								   frameInterval:1
										   image:slashTexture];
	
	[effectsManager addEffect:attackEffect0 key:@"attack0"];
	[effectsManager addEffect:attackEffect1 key:@"attack1"];
	[effectsManager addEffect:attackEffect2 key:@"attack2"];
	
	//take this out.
	Character *box = [Player characterAtPosition:CGPointMake(0.9, 0) 
									        size:CGSizeMake(0.4, 0.4) 
									 spriteSheet:sprite
								  effectsManager:effectsManager];
	
	Character *player = [Player characterAtPosition:CGPointMake(0.0, 0) 
											size:CGSizeMake(0.4, 0.4) 
								     spriteSheet:sprite
								  effectsManager:effectsManager];

	node = [Overlay nodeAtPosition:CGPointMake(0.5, 0.5) 
							  size:CGSizeMake(0.1, 0.1)
					   spriteSheet:overlaySprite];
	
	Background *background = [Background backgroundWithTexture:backgroundTexture 
												   scrollSpeed:0.01f];
	
	[[ObjectContainer singleton] addObject:background];
	[[ObjectContainer singleton] addObject:player];
	[[ObjectContainer singleton] addObject:box];
    [[ObjectContainer singleton] addObject:node];	
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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.view];
	
	DLOG(@"Point touched %.2f, %.2f", point.x, point.y);
	
	GLint screenWidth = ((EAGLView *)self.view).framebufferWidth;
	GLint screenHeight = ((EAGLView *)self.view).framebufferHeight;
	CGSize screenSize = CGSizeMake(screenWidth, screenHeight);
	CGPoint glPoint = [GraphicsEngine convertPointToGl:point 
											screenSize:screenSize];
	
	if ([node isPressed:glPoint]) {
		[node hide];
	}
}

- (void) gameLoop
{
    [(EAGLView *)self.view setFramebuffer];
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
 
    // Use shader program.
    glUseProgram(program.programId);
    
    // Animate and draw all objects
	for (id<Drawable,PhysicsContext> obj in [ObjectContainer singleton].objArray) {
		[obj update];
		
		if ([obj conformsToProtocol:@protocol(PhysicsContext)]) {
			[obj resolveCollisions];
		}
		
		[GraphicsEngine initializeProperties];
		[obj draw];
	}

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

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    [program createProgram];
	GLuint programId = program.programId;
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        DLOG("Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        DLOG("Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(programId, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(programId, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(programId, ATTRIB_VERTEX, "position");
    glBindAttribLocation(programId, ATTRIB_TEXTURE, "texture_coord");
    
    // Link program.
    if (![program linkProgram]) {
        DLOG("Failed to link program: %d", programId);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        
        return FALSE;
    }
    
    // Get uniform locations.
	ShaderConstants::uniforms[UNIFORM_OPACITY] = glGetUniformLocation(programId, "opacity");
	ShaderConstants::uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(programId, "translate");
	ShaderConstants::uniforms[UNIFORM_SCALE] = glGetUniformLocation(programId, "scale");
	ShaderConstants::uniforms[UNIFORM_ROTATE] = glGetUniformLocation(programId, "angle");
	
    
    // Set vertex and fragment shaders up for deletion when glDetachShader gets called.
    if (vertShader) {
        glDeleteShader(vertShader);
	}
    if (fragShader) {
        glDeleteShader(fragShader);
	}
    
    return TRUE;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
		    || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
