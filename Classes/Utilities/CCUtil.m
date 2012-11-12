//
//  CCUtil.m
//  DragonEye
//
//  Created by Alkaiser on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCUtil.h"

@implementation CCUtil

+ (CCLayer *) getLayer:(CCNodeTag) tagLayer {
    return (CCLayer *) [[[CCDirector sharedDirector] runningScene] getChildByTag:tagOverlayLayer];
}

@end
