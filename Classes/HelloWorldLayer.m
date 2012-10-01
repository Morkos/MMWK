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
#import "BackgroundLayer.h"

enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer ()
-(void) addNewSpriteAtPosition:(CGPoint)pos;
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
        
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"lancelotSpSheet.png" capacity:100];
		spriteTexture_ = [parent texture];

		[self addChild:parent z:1 tag:kTagParentNode];	
        
        [[SpriteSheetManager getInstance] loadFromFile:[[NSBundle mainBundle] 
                                                        pathForResource:@"spriteSheets"
                                                        ofType:@"plist"]];
       
        [self addChild:[BackgroundLayer node] z:-2];
    }
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

-(void) addNewSpriteAtPosition:(CGPoint)pos {	
	CCNode *parent = [self getChildByTag:kTagParentNode];
	
    SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] 
                                loadSpriteSheet:@"lancelotSpSheet.png"];
    CCSprite *sprite = [spriteSheet getSpriteForKey:@"walk" frameNum:0];
    
    NSArray *walkAnimFrames = [spriteSheet getSpriteFramesForKey:@"walk"];
    CCAnimation *walkAnim = [CCAnimation 
                             animationWithSpriteFrames:walkAnimFrames];
    walkAnim.delayPerUnit = 0.5f;
    
    CCAction *walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim]];
    
    [sprite runAction:walkAction];
    
    [parent addChild:sprite];
    
    sprite.position = pos;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self addNewSpriteAtPosition: location];
	}
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
