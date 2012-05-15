//
//  ParticleEffect.h
//  DragonEye
//
//  Created by alkaiser on 4/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawable.h"
#import "Prop.h"

@protocol ParticleEffect <Drawable>

@required

/**
 * Invoke effect from a specific prop source
 * @param prop The prop object used as the source
 */
- (void) invoke:(Prop *) prop;
- (bool) isActive;

@end
