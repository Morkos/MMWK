//
//  CCParticleInvoker.h
//  DragonEye
//
//  Created by Alkaiser on 10/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyConstants.h"
#import "cocos2d.h"
#import "Prop.h"

@interface ParticleInvoker : NSObject {
    CCLayer *layer;
}

@property(nonatomic, retain) CCLayer *layer;

+ (ParticleInvoker *) invoker;
- (void) invokeParticleEffect:(ParticleEffectId) idTag
                         prop:(Prop *) prop;

@end
