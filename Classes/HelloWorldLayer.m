//
//  HelloWorldLayer.m
//  DragonEye-Cocos2D
//
//  Created by mac on 9/17/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"

// Import the interfaces
#import "HelloWorldLayer.h"
#import "PhysicsSprite.h"

enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer ()
-(void) createMenu;
@end


@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
		// enable events
#ifdef __CC_PLATFORM_IOS
		self.isTouchEnabled = YES;
		//self.isAccelerometerEnabled = YES;
#elif defined(__CC_PLATFORM_MAC)
		self.isMouseEnabled = YES;
#endif
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		// title
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Multi touch the screen" fontName:@"Marker Felt" fontSize:36];
		label.position = ccp( s.width / 2, s.height - 30);
		[self addChild:label z:-1];
		
		// reset button
		[self createMenu];
		
		
#if 1
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"lancelotSpSheet.png" capacity:100];
		spriteTexture_ = [parent texture];
#else
		// doesn't use batch node. Slower
		spriteTexture_ = [[CCTextureCache sharedTextureCache] addImage:@"grossini_dance_atlas.png"];
		CCNode *parent = [CCNode node];		
#endif
		[self addChild:parent z:0 tag:kTagParentNode];	
        
        
        [[SpriteSheetManager getInstance] loadFromFile:[[NSBundle mainBundle] 
                                                        pathForResource:@"spriteSheets"
                                                        ofType:@"plist"]];
        
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        CharacterBuilder *builder = [CharacterBuilder newBuilder:ccp(20,20) 
                                                            size:CGSizeMake(10.0f, 10.0f)
                                                          sprite:[spriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]
                                     ];
        character = [[builder buildSpriteSheet:spriteSheet] build];
        
        [parent addChild:character.sprite];

		[self scheduleUpdate];
	}
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

-(void) update:(ccTime) delta {
    [character update];
}

-(void) createMenu
{	
    CCSprite *sprite = [CCSprite spriteWithFile:@"dpadNintendo.png"];
    sprite.position = ccp(50, 50);
    sprite.scale = 0.75f;
    
    dpadButton = [DpadButton buttonWithSprite:sprite];
    
	[self addChild:dpadButton.sprite z:1];	
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
		[dpadButton decideHowPlayerShouldMove:character point:location];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
		[dpadButton decideHowPlayerShouldMove:character point:location];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in touches ) {
        
        // TODO Migrate DPad to a different layer
        [character stand];
	}
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
