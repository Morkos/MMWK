//
//  NSPropertyUtil.m
//  DragonEye
//
//  Created by Mark Mikhail on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSPropertyUtil.h"

@implementation NSPropertyUtil

+ (NSDictionary *) loadProperties:(NSString *)plistFile {
    NSString * resourcePath = [[NSBundle mainBundle] bundlePath];
    NSString * filePath = [resourcePath stringByAppendingPathComponent:plistFile];
    
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}
@end
