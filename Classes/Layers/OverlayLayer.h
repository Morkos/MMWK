//
//  OverlayLayer.h
//  DragonEye
//
//  Created by mac on 10/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "FreezeModeManager.h"

@interface OverlayLayer : CCLayer {
    FreezeModeManager *freezeModeManager;
}

@property(nonatomic, retain) FreezeModeManager *freezeModeManager;

- (void) displayNodes:(NSString *) comboKey;

@end
