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
    bool isPickedUp;
}

/**
 * This gets called when a player picks up an item
 * @player The player that picks up this item
 */
- (void) isPickedUpBy:(Player *) player;

/**
 * Override this method in subclass
 * @player The player that picks up this item
 */
- (void) actionOnPickup:(Player *) player;
@end
