//
//  AttackButton.mm
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AttackButton.h"

@implementation AttackButton

- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	[[ObjectContainer singleton].player attack];
}

- (void)touchesEnded:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
}

@end
