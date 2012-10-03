//
//  DpadButton.h
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectContainer.h"
#import "Player.h"
#import "CoordinateSystem.h"

@interface DpadButton : UIImageView {
    CCSprite *sprite;
    CoordinateSystem *coordinateSystem;
}

@property(nonatomic, retain) CCSprite *sprite;
@property(nonatomic, retain) CoordinateSystem *coordinateSystem;

+ (DpadButton *) buttonWithSprite:(CCSprite *) sprite;
- (void) decideHowPlayerShouldMove:(Character *) player
                             point:(CGPoint) point;
- (bool) isLocationInView:(CGPoint) location;
@end
