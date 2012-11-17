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

@interface ParticleInvoker()
-(void) doSlashEffect:(Prop *) prop;
@end

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
        layer = [[CCUtil getLayer:tagOverlayLayer] retain]; 
    }
    return self;
}

- (void) invokeParticleEffect:(ParticleEffectId) idTag 
                         prop:(Prop *) target {
    switch (idTag) {
        case slashEffect:
            [self doSlashEffect:target];
            break;
            
        default:
            break;
    }
}

/*** Methods for various particle effects ***/
- (void) doSlashEffect:(Prop *) prop {
    CGPoint position = prop.position;
    CCBlade *blade = [CCBlade bladeWithMaximumPoint:50];
    blade.autoDim = NO;
    blade.texture = [[CCTextureCache sharedTextureCache] addImage:@"streak1.png"];
    
    [layer addChild:blade];
    
    NSLog(@"Prop position: %lf, %lf", position.x, position.y);
    CCFiniteTimeAction *action = [CCMoveTo actionWithDuration:0.15f position:ccpAdd(position, ccp(0, -50.f))];
    
    /*ccBezierConfig bezierConfig;
     bezierConfig.controlPoint_1 = ccp(10, -10);
     bezierConfig.controlPoint_2 = ccp(10, -20);
     bezierConfig.endPosition = ccp(0, -50);
     CCBezierBy *action = [CCBezierBy actionWithDuration:0.2f bezier:bezierConfig];*/
    
    [blade setPosition:position];
    
    CCAction *bladeAction = 
        [CCSequence actions:action, [CCCallFunc actionWithTarget:blade selector:@selector(finish)], nil];
    
    [blade runAction:bladeAction];
}

- (void) dealloc {
    [layer release];
    [super dealloc];
}

@end
