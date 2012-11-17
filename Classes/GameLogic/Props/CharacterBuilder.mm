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

+ (CharacterBuilder *) newBuilder:(CGPoint) position 
             size:(CGSize) size 
           spriteFrame:(CCSpriteFrame *) spriteFrame{
    CharacterBuilder *builder = [[CharacterBuilder alloc] init];
    builder.character = [[Character alloc] init:position 
                                           size:size
                                         spriteFrame:spriteFrame];
    
    
    return builder;
}

- (CharacterBuilder *) buildSpriteSheet:(SpriteSheet *) spriteSheet {
    self.character.spriteSheet = spriteSheet;
    return self;
}

- (CharacterBuilder *) buildHealth:(NSUInteger) health {
    self.character.maxHp = health;
    self.character.currentHp = health;
    return self;
}

- (CharacterBuilder *) buildDefense:(NSUInteger) defense {
    self.character.defense = defense;
    return self;
}

- (CharacterBuilder *) buildStrength:(NSUInteger) strength {
    self.character.strength = strength;
    return self;
}

- (CharacterBuilder *) buildSpeed:(CGFloat)speed {
    self.character.speed = speed;
    return self;
}

- (CharacterBuilder *) buildHealthGauge:(Gauge *) healthGauge {
    self.character.healthGauge = healthGauge;
    return self;
}

- (id) build {
    [self.character setState:
     [StandState createWithCharacter:self.character]];
    return self.character;
}

@end
