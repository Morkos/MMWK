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
                                  barTextures:(NSArray *) barTextures
                                     position:(CGPoint) position
                                        scale:(CGSize)scale {
    return [[[VerticalGauge alloc] initWithContainerTexture:containerTexture 
                                                barTextures:barTextures
                                                   position:position
                                                      scale:scale] autorelease];
}

// Override
-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures
                      position:(CGPoint) position
                         scale:(CGSize) scale {
    
    if (self = [super initWithContainerTexture:containerTexture
                                   barTextures:barTextures 
                                      position:position 
                                         scale:scale]) {
        containerSprite.rotation = 90;
        barSprite.rotation = 90;
    }
    
    return self;
}
@end
