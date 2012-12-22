//
//  BattleLayer.h
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "BattlePlayer.h"

@interface BattleLayer : CCLayer {
    NSArray *enemies;
    BattlePlayer *player;
    bool isBattleTimerOn;
}

@end
