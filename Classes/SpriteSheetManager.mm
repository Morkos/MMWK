//
//  SpriteSheetManager.mm
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheetManager.h"

static SpriteSheetManager *manager = nil;

@implementation SpriteSheetManager

@synthesize decoder,
            textureManager,
            columnDict;

+ (SpriteSheetManager *) getInstance {
    if(manager == nil) {
		manager = [[SpriteSheetManager alloc] init];
		manager.decoder = [JSONDecoder decoder];
        manager.textureManager = [TextureManager getInstance];
        manager.columnDict = [NSMutableDictionary dictionaryWithCapacity:10];
	}
	
	return manager;
}

- (void) loadFromFile:(NSString *) jsonFilepath {
	NSData *jsonData = [NSData dataWithContentsOfURL:
                        [NSURL fileURLWithPath:jsonFilepath]];
    
    NSDictionary *items = [decoder objectWithData:jsonData];
    
    for(NSString *filename in [items allKeys]) {
        NSDictionary *attributes = [items objectForKey:filename];
        NSArray *columns = [attributes objectForKey:@"columns"];
        NSString *filetype = [attributes objectForKey:@"filetype"];
        
        NSString *filepath = [[NSBundle mainBundle] 
                                pathForResource:filename
                                         ofType:filetype];
        
        NSArray *pair = [NSArray arrayWithObjects:columns,
                                                  filepath,
                                                  nil];

        [self.columnDict setObject:pair forKey:filename];
    }
}

- (SpriteSheet *) loadSpriteSheet:(NSString *) filename {
    NSArray *pair = [self.columnDict objectForKey:filename];
    
    NSString *filepath = [pair objectAtIndex:1];
    Texture *texture = [textureManager loadTexture:filepath];
    
    NSArray *columns = [pair objectAtIndex:0];
    
    SpriteSheet *spSheet = [SpriteSheet createWithTexture:texture
                                                  columns:columns];
    
    return spSheet;
}

- (Texture *) loadTexture:(NSString *) filename {
    NSArray *pair = [self.columnDict objectForKey:filename];
    NSString *filepath = [pair objectAtIndex:1];
    Texture *texture = [textureManager loadTexture:filepath];
    
    return texture;
}

@end
