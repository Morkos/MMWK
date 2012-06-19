//
//  AttackButton.h
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectContainer.h"


@interface AttackButton : UIImageView {

}

/**
 * Every touch on the attack button (bottom-right corner),
 * this function will be called.
 */
- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event;

@end
