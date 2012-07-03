//
//  SpriteSheetManager.h
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "TextureManager.h"
#import "SpriteSheet.h"

/**
 * A utility class to manage the creation of sprite sheets
 * from a json file.
 */
@interface SpriteSheetManager : NSObject {
    JSONDecoder *decoder;
    TextureManager *textureManager;
    
    // A map of filenames (without extension) -> [columns, filepath]
    NSMutableDictionary *columnDict;
}

@property (nonatomic, retain) JSONDecoder * decoder;
@property (nonatomic, retain) TextureManager *textureManager;
@property (nonatomic, retain) NSMutableDictionary *columnDict;

+ (SpriteSheetManager *) getInstance;

- (void) loadFromFile:(NSString *) jsonFilepath;

/**
 * Loads a sprite sheet based on the filename provided in the JSON
 * file. 
 *
 * @filename: The key provided in the JSON file (without extension)
 */
- (SpriteSheet *) loadSpriteSheet:(NSString *) filename;

/**
 * Loads a texture based on the filename provided in the JSON
 * file. 
 *
 * @filename: The key provided in the JSON file (without extension)
 */
- (Texture *) loadTexture:(NSString *) filename;

@end 
