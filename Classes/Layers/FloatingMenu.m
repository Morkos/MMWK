//
//  FloatingMenu.m
//  DragonEye
//
//  Created by Mark Mikhail on 1/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FloatingMenu.h"

#define STARTING_WINDOW_OFFSET 25

static NSUInteger slideActionWindowTag = 100;

@implementation FloatingMenu
@synthesize menu;

/**
 * TODO: add basic physics to this layer. 
 * Use velocity of finger swipe to calculate velocity of sliding window
 */
-(id) init {
    if( self = [super initWithColor:ccc4(0, 0, 0, 225)] ) {
        
        self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF * label = [CCLabelTTF labelWithString:@"Move it"
                                            fontName:@"Courier"
                                            fontSize:20];
        
        CCMenuItemFont * item = [CCMenuItemFont itemWithLabel:label];
        
        self.menu = [CCMenu menuWithItems:item, nil];
        self.menu.position = ccp( size.width / 2, size.height / 2 );
        self.position = ccp( size.width - STARTING_WINDOW_OFFSET, 0 );
        
        [self.menu setColor:ccWHITE];
        [self addChild:self.menu];

    }
    
    return self;
}

- (void) ccTouchesMoved:(NSSet *)touches 
              withEvent:(UIEvent *)event {
    
    UITouch * touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    [self stopActionByTag:slideActionWindowTag];
        
    CGPoint diff = ccpSub(location, self.position);        
    self.position = ccp(self.position.x + diff.x, self.position.y);
}

- (void) ccTouchesEnded:(NSSet *)touches 
              withEvent:(UIEvent *)event {
    
    UITouch * touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    NSUInteger directionToSlide = STARTING_WINDOW_OFFSET;

    if(location.x < size.width / 3) {
        directionToSlide = size.width;
    }
    
    CCMoveTo * slide = [CCMoveTo actionWithDuration:0.5f 
                                           position:ccp(size.width - directionToSlide, 0)];
    slide.tag = slideActionWindowTag;
    [self runAction:slide];
    
}

@end
