//
//  BackgroundLayer.m
//  DragonEye
//
//  Created by Mark Mikhail on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"
#import "cocos2d.h"
#import "NSPropertyUtil.h"
#import "SpriteSheetManager.h"
#import "PlayerBuilder.h"
#import "Enemy.h"
#import "ObjectContainer.h"

@implementation BackgroundLayer
@synthesize sequences;

- (id) init {
    
    if(self = [super init]) {
        CCLOG(@"Initializing background...");
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSDictionary * lvlProperties = [NSPropertyUtil loadProperties:@"level0.plist"];
        NSArray * bgImages = [lvlProperties objectForKey:@"backgroundImages"];
        
        self.sequences = [lvlProperties objectForKey:@"backgroundSequences"];
        
        /**
         * POTENTIAL OPTIMIZATION: We are adding a sprite for every sequence; however, sequences can be 
         * duplicated.
         */
        int i = 0;
        for (NSNumber * sqIndex in self.sequences) {
            NSInteger imgIndex = [sqIndex integerValue];
            
            CCSprite * fillerSprite = [[CCSprite alloc] init];
            CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:
                                     [bgImages objectAtIndex:imgIndex]];
            
            CGSize textureSize = CGSizeMake(texture.contentSize.width, texture.contentSize.height);

            [fillerSprite initWithTexture:texture
                                     rect:CGRectMake(0, 0, textureSize.width, textureSize.height)];
            /**
             * Adjust each BG position to be side by side.
             */
            CGFloat newPositionX = ((screenSize.width * (i + 1)) + (screenSize.width * i)) / 2;
            fillerSprite.position = ccp(newPositionX, screenSize.height/2);
            
            //add to scene 
            [self addChild:fillerSprite];
            [fillerSprite release]; 
            i++;
        }
    }
    
    return self;
}

@end
