//
//  BattlePlayer.h
//  DragonEye
//
//  Created by Alkaiser on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleCharacter.h"
#import "Gauge.h"

@interface BattlePlayer : BattleCharacter {
    Gauge *waitTimeGauge;
}

@property(nonatomic, retain) Gauge *waitTimeGauge;

@end
