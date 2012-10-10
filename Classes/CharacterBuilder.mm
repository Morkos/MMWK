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

+ (id) newBuilder:(CGPoint) position 
                             size:(CGSize) size 
                           sprite:(CCSprite *)sprite{
    CharacterBuilder *builder = [[CharacterBuilder alloc] init];
    builder.character = [[Character alloc] init:position 
                                           size:size
                                         sprite:sprite];
    
    
    return builder;
}

- (id) buildSpriteSheet:(SpriteSheet *) spriteSheet {
    self.character.spriteSheet = spriteSheet;
    return self;
}

- (id) buildParticleEffectsManager:(ParticleEffectsManager *)manager {
    self.character.effectsManager = manager;
    return self;
}

- (id) buildDefense:(NSUInteger)defense {
    self.character.defense = defense;
    return self;
}

- (id) buildStrength:(NSUInteger)strength {
    self.character.strength = strength;
    return self;
}

- (id) build {
    [self.character setState:
     [StandState createWithCharacter:self.character]];
    return self.character;
}

@end
