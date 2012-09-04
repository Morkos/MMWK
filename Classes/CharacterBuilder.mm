//
//  CharacterBuilder.m
//  DragonEye
//
//  Created by Mark Mikhail on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterBuilder.h"

@implementation CharacterBuilder

@synthesize character;

- (CharacterBuilder *) newBuilder:(CGPoint)position 
                             size:(CGSize)size {
    [character autorelease];
    character = [[Character alloc] init:position 
                                   size:size];
    
    return self;
}

- (CharacterBuilder *) buildAnimator:(SpriteSheetAnimator *)animator {
    self.character.animator = animator;
    return self;
}

- (CharacterBuilder *) buildParticleEffectsManager:(ParticleEffectsManager *)manager {
    self.character.effectsManager = manager;
    return self;
}

- (CharacterBuilder *) buildDefense:(NSUInteger)defense {
    self.character.defense = defense;
    return self;
}

- (CharacterBuilder *) buildStrength:(NSUInteger)strength {
    self.character.strength = strength;
    return self;
}

- (Character *) build {
    [self.character setState:
     [StandState createWithCharacter:self.character]];
    return self.character;
}

@end
