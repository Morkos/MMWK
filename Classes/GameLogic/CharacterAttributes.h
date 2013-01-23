//
//  CharacterAttributes.h
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterAttributes : NSObject {
    NSUInteger maxHp, 
               currentHp, 
               attackPower, 
               magicPower;
}

@property(nonatomic, assign) NSUInteger maxHp; 
@property(nonatomic, assign) NSUInteger currentHp;
@property(nonatomic, assign) NSUInteger attackPower;
@property(nonatomic, assign) NSUInteger magicPower;

/**
 * Decreases the currentHp by the given parameter.
 * @param hpDecrease the amount of hp decreased.
 */
-(void) decreaseHp:(NSUInteger) hpDecrease;

@end
