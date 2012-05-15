//
//  ParticleManager.h
//  DragonEye
//
//  Created by alkaiser on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleEffect.h"
#import "Prop.h"


@interface ParticleEffectsManager : NSObject {
	NSMutableDictionary *particleEffects;
}

@property (nonatomic, retain) NSMutableDictionary *particleEffects;

/**
 * Create a particle effects manager that stores various particle effects
 * @param prop The prop the particle manager is tied to
 * @param numEffects Default number of particle effects
 */
+ (ParticleEffectsManager *) manager:(NSUInteger)numEffects;

/**
 * Add a particle effect to the particle manager
 * @param effect The effect to add
 * @param key The key to reference the effect with
 */
- (void) addEffect:(id<ParticleEffect>) effect 
			   key:(NSString *) key;

/**
 * Invoke the particle effect on the prop
 * @param key The key to reference the effect with
 * @param 
 */
- (void) invokeEffect:(NSString *) key 
				 prop:(Prop *) prop;

@end
