//
//  NSDictionaryToArray.m
//  DragonEye
//
//  Created by Alkaiser on 11/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionaryExtensions.h"

@implementation NSMutableDictionary(NSDictionaryExtensions)

- (void) addObjectToArray:(id)object forKey:(NSString *) key {
    id value = [self objectForKey:key];
    if (!value) {
        value = [NSMutableArray array];
        [self setValue:value forKey:key];         
    } else if (!IS_SUBCLASS(value, NSMutableArray)) {
        return;
    }
    
    [(NSMutableArray *) value addObject:object];
}

-(void) incrementNumberForKey:(NSString *) key {
    NSNumber *value = [self objectForKey:key];
    if (!value) {
        value = [NSNumber numberWithInt:0];
    } else if (!IS_SUBCLASS(value, NSNumber)) {
        return;
    }
    
    value = [NSNumber numberWithInt:[value intValue] + 1];
    [self setValue:value forKey:key];
}

@end
