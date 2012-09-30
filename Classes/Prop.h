//
//  Prop.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Typedefs.h"
#import "Collidable.h"
#import "Drawable.h"
#import "cocos2d.h"

@interface Prop : NSObject <Drawable, Collidable> {
	CGPoint position;
	CGSize  size;
    CCSprite *sprite;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) CCSprite *sprite;

@end
