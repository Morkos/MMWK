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

static CGFloat SCROLL_SPEED = 1.0f;
static CGSize screenSize;
static int sqIndex = 0;

@implementation BackgroundLayer
@synthesize bgSprites,
            sequences;

/**
 * Private helper method to see if we are at the end of 
 * our level
 */
- (BOOL) isBackgroundFinished {
    NSInteger elementCount = [self.bgSprites count];
    return ((sqIndex + 1) >= elementCount);
}

- (id) init {
    
    if(self = [super init]) {
        NSLog(@"Initializing background...");
        
        screenSize = [[CCDirector sharedDirector] winSize];
        NSDictionary * lvlProperties = [NSPropertyUtil loadProperties:@"level0.plist"];
        NSArray * bgImages = [lvlProperties objectForKey:@"backgroundImages"];
        
        self.sequences = [lvlProperties objectForKey:@"backgroundSequences"];
        self.bgSprites = [NSMutableArray arrayWithCapacity:[self.sequences count]];
        
        /**
         * POTENTIAL OPTIMIZATION: We are adding a sprite for every sequence; however, sequences can be 
         * duplicated.
         */
        for (NSNumber * sqIndex in self.sequences) {
            NSInteger imgIndex = [sqIndex integerValue];
            
            CCSprite * fillerSprite = [[CCSprite alloc] init];
            CCTexture2D * texture = [[CCTextureCache sharedTextureCache] addImage:
                                     [bgImages objectAtIndex:imgIndex]];
            
            CGSize textureSize = CGSizeMake(texture.contentSize.width, texture.contentSize.height);

            [fillerSprite initWithTexture:texture
                                      rect:CGRectMake(0, 0, textureSize.width, textureSize.height)];
            /**
             * Adjust each BG position to be outside and 
             * to the right of the current iphone's screen view
             */
            fillerSprite.position = ccp(screenSize.width + (screenSize.width / 2), screenSize.height/2);
            //fillerSprite.scaleY = 0.5;
            [self.bgSprites addObject:fillerSprite];      
            
            //add to scene 
            [self addChild:fillerSprite];
            [fillerSprite release];
        }
        
        /**
         * Center the 1st bg sprite
         */
        CCSprite * bg1 = [self.bgSprites objectAtIndex:0];        
        bg1.position = ccp(screenSize.width / 2, screenSize.height / 2);

        [self scheduleUpdate];
    }
    
    return self;
}

- (void) update:(ccTime) dt {
        
    if ([self isBackgroundFinished]) {
        NSLog(@"Descheduling background.");
        [self unscheduleUpdate];
        return;
    }
    
    //NOTE: This assumes that we just need 1 bg image per scene.
    NSMutableArray * scrollingBackgrounds = [NSMutableArray arrayWithObjects:
                                             [self.bgSprites objectAtIndex:sqIndex],
                                             [self.bgSprites objectAtIndex:sqIndex + 1],
                                             nil
                                            ];
    
    for (CCSprite * bg in scrollingBackgrounds) {
        bg.position = ccp( bg.position.x - SCROLL_SPEED, bg.position.y );
        //if bg is scrolld all th way to th lft, thn ftch th nxt bg imag
        if (bg.position.x <= - (screenSize.width / 2 - 1)) {
            sqIndex++;
        }
    }
}

@end
