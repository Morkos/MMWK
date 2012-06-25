//
//  TextureManager.m
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextureManager.h"

static TextureManager *manager = nil;

@implementation TextureManager

@synthesize textures;

+ (TextureManager *) getInstance {
    if (!manager) {
        manager = [[TextureManager alloc] init];
        manager.textures = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return manager;
}

- (Texture *) loadTexture:(NSString *) filepath {
    Texture *existingTexture = [textures objectForKey:filepath];
    if (existingTexture) {
        return existingTexture;
    }
    
    Texture *newTexture = [Texture textureWithFilename:filepath];
    [textures setValue:newTexture forKey:filepath];
    
    return newTexture;
}

- (void) releaseAllTextures {
    // OPTIMIZE Can batch glDeleteTextures instead
    
    //This will call release of all texture objects, which 
    //in turn will call dealloc which will release the textures
    //from OpenGl. Since its a release however, this requires 
    //every object who has texture references to call release too
    [textures removeAllObjects];
}

@end
