//
//  BattleCharacter.h
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "SpriteSheet.h"
#import "CharacterAttributes.h"

@interface BattleCharacter : Prop {
    SpriteSheet * spriteSheet;
    CharacterAttributes *attributes;
    CGFloat waitTimeDelay;
}

@property(nonatomic, retain) SpriteSheet *spriteSheet;
@property(nonatomic, retain) CharacterAttributes *attributes;
@property(nonatomic, assign) CGFloat waitTimeDelay;

-(void) isAttackedBy:(BattleCharacter *) target;
-(void) startBattleTimer:(CCFiniteTimeAction *) targetAction;

@end
