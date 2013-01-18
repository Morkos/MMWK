//
//  CCParticleInvoker.m
//  DragonEye
//
//  Created by Alkaiser on 10/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParticleInvoker.h"
#import "OverlayLayer.h"
#import "CCBlade.h"
#import "CCUtil.h"
#import "CoordinateSystem.h"

@implementation ParticleInvoker
static ParticleInvoker * invoker = nil;

@synthesize layer;

+ (ParticleInvoker *) invoker {
    if (!invoker) {
        invoker = [[ParticleInvoker alloc] init];
    }
    
    return invoker;
}

- (id) init {
    if (self = [super init]) {
        layer = [[CCUtil getLayer:tagWorldLayer] retain]; 
    }
    
    return self;
}

// Deprecated
- (void) invokeParticleEffect:(ParticleEffectId) idTag 
                         prop:(Prop *) target {
}

/*** Methods for various particle effects ***/
-(void) doSlashEffect:(Prop *) prop
                angle:(CGFloat) angle
               length:(CGFloat) length {
    CCBlade *blade = [CCBlade bladeWithMaximumPoint:50];
    blade.autoDim = NO;
    blade.texture = [[CCTextureCache sharedTextureCache] addImage:@"streak1.png"];
    
    CGPoint slashVector = ccpMult(ccpForAngle(angle), length);
    
    CCLOG(@"Slash vector: %@", NSStringFromCGPoint(ccpForAngle(angle)));
    CCFiniteTimeAction *action = 
        [CCMoveBy actionWithDuration:0.15f position:slashVector];
    CCAction *bladeAction = 
        [CCSequence actions:action, [CCCallFunc actionWithTarget:blade selector:@selector(finish)], nil];
    
    CGPoint midSpritePosition = ccp(prop.boundingBox.size.width/2, prop.boundingBox.size.height/2);
    
    [prop addChild:blade];
    [blade setPosition:ccpSub(midSpritePosition, ccpMult(slashVector, 0.5))];
    [blade runAction:bladeAction];
}

- (void) dealloc {
    [layer release];
    [super dealloc];
}

@end
