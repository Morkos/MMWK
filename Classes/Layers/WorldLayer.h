//
//  HelloWorldLayer.h
//  DragonEye-Cocos2D
//
//  Created by mac on 9/17/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "chipmunk.h"
#import "SpriteSheet.h"
#import "NSPropertyUtil.h"

@interface WorldLayer : CCLayer
{
	CCTexture2D *spriteTexture_; // weak ref
}
@end
