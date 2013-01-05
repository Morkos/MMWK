//
//  BattleEnemy.h
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleCharacter.h"

@interface BattleEnemy : BattleCharacter {
    CCLabelTTF *debugLabel;
    CGFloat currentWaitTime;
}

@property(nonatomic, retain) CCLabelTTF *debugLabel;

@end
