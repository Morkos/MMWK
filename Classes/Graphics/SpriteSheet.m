//
//  SpriteSheet.m
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"

@interface SpriteSheet ()
- (CCSpriteFrame *) getFrameForKey:(NSString *) key frameNum:(NSUInteger) frameNum;
@end

@implementation SpriteSheet

@synthesize texture, 
			sizeX, 
			sizeY,
            animationFrames;

+ (SpriteSheet *) createWithTexture:(CCTexture2D *) texture 
                    animationFrames:(NSDictionary *) animationFrames 
                          numOfRows:(NSUInteger) numOfRows
                       numOfColumns:(NSUInteger) numOfColumns {
	
	SpriteSheet *spriteSheet = [[SpriteSheet alloc] init];
	spriteSheet.texture = texture;
	spriteSheet.sizeX = ([texture pixelsWide] / numOfColumns);
	spriteSheet.sizeY = ([texture pixelsHigh] / numOfRows);
    spriteSheet.animationFrames = animationFrames;
    
    for (NSString *key in animationFrames) {
        NSArray *animationKeys = [animationFrames valueForKey:key];
        for (int i = 0; i < [animationKeys count]; i++) {
            CGPoint rowColPair = CGPointFromString([animationKeys objectAtIndex:i]);
            NSUInteger row = rowColPair.x;
            NSUInteger column = rowColPair.y;
            CGFloat topLeftX = spriteSheet.sizeX * column;
            CGFloat topLeftY = spriteSheet.sizeY * row;
            
            CCSpriteFrame *frame = 
                [CCSpriteFrame frameWithTexture:texture 
                                           rect:CGRectMake(topLeftX, topLeftY, spriteSheet.sizeX, spriteSheet.sizeY)];
            
            NSString * frameKey = [NSString stringWithFormat:@"%d.%@%d", texture.name, key, i];
            
            NSLog(@"Adding frameKey: %@ to SpriteFrameCache.", frameKey);
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
                addSpriteFrame:frame name:[NSString stringWithFormat: @"%d.%@%d", texture.name, key, i]];
        }
    }
	
	return spriteSheet;
}

- (NSUInteger) getNumOfFramesForKey:(NSString *) key {
	return [[self.animationFrames objectForKey:key] count];
}

- (NSArray *) getSpriteFramesForKey:(NSString *) key {
    NSUInteger numOfFrames = [self getNumOfFramesForKey:key];
    NSMutableArray *spriteFrames = [NSMutableArray arrayWithCapacity:numOfFrames];
    
    for (int i = 0; i < numOfFrames; i++) {
        CCSpriteFrame *frame = [self getFrameForKey:key frameNum:i];
        [spriteFrames addObject:frame];
    }
    
    return spriteFrames;
}

- (CCSprite *) getSpriteForKey:(NSString *) key frameNum:(NSUInteger) frameNum {
    CCSpriteFrame *frame = [self getFrameForKey:key frameNum:frameNum];
    return [CCSprite spriteWithTexture:self.texture rect:frame.rect];
}

- (void) changeSprite:(CCSprite *) sprite   
                toKey:(NSString *) key 
             frameNum:(NSUInteger) frameNum {
    CCSpriteFrame *frame = [self getFrameForKey:key frameNum:frameNum];
    [sprite setTextureRect:frame.rect];
}

- (CCSpriteFrame *) getFrameForKey:(NSString *) key frameNum:(NSUInteger) frameNum {
    NSString *frameKey = [NSString stringWithFormat:@"%d.%@%d", self.texture.name, key, frameNum];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameKey];
    return frame;
}

@end
