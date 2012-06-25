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

- (SpriteSheet *) loadSpriteSheet:(NSString *) filename;
- (Texture *) loadTexture:(NSString *) filename;

@end 
