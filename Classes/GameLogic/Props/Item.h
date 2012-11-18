//
//  Item.h
//  DragonEye
//
//  Created by Alkaiser on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "SpriteSheet.h"
#import "Player.h"

@interface Item : Prop {
    
}

- (void) isPickedUpBy:(Player *) player;

@end
