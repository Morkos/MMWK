//
//  ParticleEffectsManager.mm
//  DragonEye
//
//  Created by alkaiser on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ParticleEffectsManager.h"


@implementation ParticleEffectsManager

@synthesize particleEffects,
            currentEffect;

+ (ParticleEffectsManager *) manager:(NSUInteger)numEffects {
	
	ParticleEffectsManager *manager = [[ParticleEffectsManager alloc] init];
	manager.particleEffects = [NSMutableDictionary dictionaryWithCapacity:numEffects];
	
	return manager;
}

- (void) addEffect:(id<ParticleEffect>) effect 
			   key:(NSString *) key {
	[particleEffects setObject:effect forKey:key];
}

- (void) invokeEffect:(NSString *) key 
				 prop:(Prop *) prop {
    currentEffect = [particleEffects objectForKey:key];
	[currentEffect invoke:prop];
}

- (void) updateCurrentEffect {
    [currentEffect update];
}
@end
