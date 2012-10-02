//
//  SpriteSheetManager.h
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "SpriteSheet.h"

/**
 * A utility class to manage the creation of sprite sheets
 * from a json file.
 */
@interface SpriteSheetManager : NSObject {
    
    // A map of filenames (without extension) -> [columns, filepath]
    NSMutableDictionary *attributesStore;
}

@property (nonatomic, retain) NSMutableDictionary *attributesStore;

+ (SpriteSheetManager *) getInstance;

- (void) loadFromItems:(NSDictionary *) items;

/**
 * Loads a sprite sheet based on the filename provided in the JSON
 * file. 
 *
 * @filename: The key provided in the JSON file (without extension)
 */
- (SpriteSheet *) loadSpriteSheet:(NSString *) filename;

@end 
