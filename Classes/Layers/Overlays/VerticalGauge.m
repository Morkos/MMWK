//
//  EnemyHealthGauge.m
//  DragonEye
//
//  Created by Alkaiser on 11/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VerticalGauge.h"

@implementation VerticalGauge

+ (VerticalGauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                                  barTextures:(NSArray *) barTextures {
    return [[[VerticalGauge alloc] initWithContainerTexture:containerTexture 
                                                barTextures:barTextures] autorelease];
}

// Override
-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures {
    
    if (self = [super initWithContainerTexture:containerTexture
                                   barTextures:barTextures]) {
        containerSprite.rotation = 90;
        barProgressTimer.rotation = 90;
    }
    
    return self;
}
@end
