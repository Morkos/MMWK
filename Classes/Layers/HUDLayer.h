//
//  HUDLayer.h
//  DragonEye
//
//  Created by mac on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "DpadButton.h"
#import "AttackButton.h"

@interface HUDLayer : CCLayer {
    DpadButton *dpadButton;
    AttackButton *attackButton;
}

@end
