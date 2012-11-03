//
//  CharacterBuilder.h
//  DragonEye
//
//  Created by Mark Mikhail on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "cocos2d.h"

@interface CharacterBuilder : NSObject {

    @protected 
    Character * character;
    
}

@property (nonatomic, retain) Character * character;

+ (CharacterBuilder *) newBuilder:(CGPoint)position
                             size:(CGSize)size
                           spriteFrame:(CCSpriteFrame *)spriteFrame;

- (CharacterBuilder *) buildSpriteSheet:(SpriteSheet *) spriteSheet;
- (CharacterBuilder *) buildStrength:(NSUInteger) strength;
- (CharacterBuilder *) buildDefense:(NSUInteger) defense;
- (id) build;


@end
