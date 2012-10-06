//
//  HUDControl.h
//  DragonEye
//
//  Created by mac on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HUDControl : NSObject {
    CCSprite *sprite;
}

@property(nonatomic, retain) CCSprite *sprite;

- (bool) isLocationInView:(CGPoint) location;

@end
