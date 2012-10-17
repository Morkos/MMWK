//
//  MacroHelpers.h
//  DragonEye
//
//  Created by Mark Mikhail on 10/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "ObjectContainer.h"

extern Player * getPlayer() {
    return [ObjectContainer sharedInstance].player;
}
