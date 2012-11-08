//
//  NSDictionaryToArray.h
//  DragonEye
//
//  Created by Alkaiser on 11/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(NSDictionaryExtensions)
    -(void) addObjectToArray:(id)object forKey:(NSString *) key;
@end
