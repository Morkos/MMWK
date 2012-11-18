//
//  HealthPotion.h
//  DragonEye
//
//  Created by Alkaiser on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@interface HealthPotion : Item {
    CGFloat hpIncrease;
}

+ (HealthPotion *) itemWithTexture:(NSString *) textureFilename;
@end
