//
//  BackgroundLayer.h
//  DragonEye
//
//  Created by Mark Mikhail on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackgroundLayer : CCLayer {
    NSMutableArray * bgSprites;
    NSArray * sequences;
}

@property (nonatomic, retain) NSMutableArray * bgSprites;
@property (nonatomic, retain) NSArray * sequences;

@end
