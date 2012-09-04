//
//  CharacterBuilder.h
//  DragonEye
//
//  Created by Mark Mikhail on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface CharacterBuilder : NSObject {

    @protected 
    Character * character;
    
}

@property (nonatomic, retain) Character * character;

- (CharacterBuilder *) newBuilder:(CGPoint)position
                             size:(CGSize)size;

- (CharacterBuilder *) buildAnimator:(SpriteSheetAnimator *) animator;
- (CharacterBuilder *) buildParticleEffectsManager:(ParticleEffectsManager *) manager;
- (CharacterBuilder *) buildStrength:(NSUInteger) strength;
- (CharacterBuilder *) buildDefense:(NSUInteger) defense;
- (Character *) build;


@end
