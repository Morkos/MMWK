//
//  CCParticleInvoker.h
//  DragonEye
//
//  Created by Alkaiser on 10/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Prop.h"

@interface ParticleInvoker : NSObject {
    CCLayer *layer;
}

@property(nonatomic, retain) CCLayer *layer;

+ (ParticleInvoker *) invoker;

// Deprecated. Use individual particle effects instead
- (void) invokeParticleEffect:(ParticleEffectId) idTag
                         prop:(Prop *) prop;

-(void) doSlashEffect:(Prop *) prop
                angle:(CGFloat) angle
               length:(CGFloat) length; 

@end
