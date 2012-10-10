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

@synthesize attributesStore;

+ (SpriteSheetManager *) getInstance {
    if(manager == nil) {
		manager = [[[SpriteSheetManager alloc] init] autorelease];
        manager.attributesStore = [NSMutableDictionary dictionaryWithCapacity:10];
	}
	
	return manager;
}

- (void) loadFromItems:(NSDictionary *) items {
    for(NSString *filename in [items allKeys]) {
        NSDictionary *attributes = [items objectForKey:filename];
        
        [self.attributesStore setObject:attributes forKey:filename];
    }
}

- (SpriteSheet *) loadSpriteSheet:(NSString *) filename {
    NSDictionary *attributes = [self.attributesStore objectForKey:filename];
    NSNumber *numOfColumns = [attributes objectForKey:@"numOfColumns"];
    NSNumber *numOfRows = [attributes objectForKey:@"numOfRows"];
    NSDictionary *animationFrames = [attributes objectForKey:@"animationFrames"];
    
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:filename];
    SpriteSheet *spSheet = [SpriteSheet createWithTexture:texture
                                          animationFrames:animationFrames
                                                numOfRows:[numOfRows intValue]
                                             numOfColumns:[numOfColumns intValue]];
    
    return spSheet;
}

@end
