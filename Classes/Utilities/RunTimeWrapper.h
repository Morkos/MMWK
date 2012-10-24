//
//  RunTimeWrapper.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RunTimeWrapper : NSObject {

}

/**
 * Call a method with no args via a string at runtime.
 * 
 * @param NSString * prefix of the method name to be called
 * @param NSObject * the object you are calling the method on
 */
+ (void) callWithNoArgs:(NSString *) prefix
				 object:(NSObject *) object;

@end
