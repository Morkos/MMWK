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
           spriteFrame:(CCSpriteFrame *) spriteFrame{
    CharacterBuilder *builder = [[CharacterBuilder alloc] init];
    builder.character = [[Character alloc] init:position 
                                           size:size
                                         spriteFrame:spriteFrame];
    
    
    return builder;
}

- (id) buildSpriteSheet:(SpriteSheet *) spriteSheet {
    self.character.spriteSheet = spriteSheet;
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
