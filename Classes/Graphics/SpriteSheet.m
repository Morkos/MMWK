//
//  SpriteSheet.m
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheet.h"
#import "NSPropertyUtil.h"
#import "NSDictionaryExtensions.h"

@interface SpriteSheet ()
- (CCSpriteFrame *) getFrameForKey:(NSString *) key frameNum:(NSUInteger) frameNum;
@end

@implementation SpriteSheet

@synthesize texture, 
            textureName,
			sizeX, 
			sizeY,
            numOfFramesForKey;

+ (SpriteSheet *) createWithTexture:(CCTexture2D *) texture 
                    animationFrames:(NSDictionary *) animationFrames 
                          numOfRows:(NSUInteger) numOfRows
                       numOfColumns:(NSUInteger) numOfColumns {
	
	SpriteSheet *spriteSheet = [[SpriteSheet alloc] init];
	spriteSheet.texture = texture;
	spriteSheet.sizeX = ([texture pixelsWide] / numOfColumns);
	spriteSheet.sizeY = ([texture pixelsHigh] / numOfRows);
    spriteSheet.numOfFramesForKey = [[NSMutableDictionary dictionary] retain];
    spriteSheet.textureName = NSSTRING_FORMAT(@"%d", texture.name);
    
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
            
            NSString * frameKey = [NSString stringWithFormat:@"%@-%@%d", spriteSheet.textureName, key, i];
            
            NSLog(@"Adding frameKey: %@ to SpriteFrameCache.", frameKey);
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
                addSpriteFrame:frame name:frameKey];
        }
        
        [spriteSheet.numOfFramesForKey setObject:[NSNumber numberWithInt:[animationKeys count]]
                                          forKey:key];
    }
	
	return spriteSheet;
}

+ (SpriteSheet *) createWithFile:(NSString *) filename {
    SpriteSheet *spriteSheet = [[[SpriteSheet alloc] init] autorelease];
    
    NSString *textureFilename = NSSTRING_FORMAT(@"%@.png", filename);
    NSString *plistFilename = NSSTRING_FORMAT(@"%@.plist", filename);
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:textureFilename];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plistFilename texture:texture];
    
    spriteSheet.texture = texture;
    spriteSheet.textureName = filename;
    spriteSheet.numOfFramesForKey = [[NSMutableDictionary dictionary] retain];
    
    // NOTE: IOS 4 only
    NSRegularExpression *regex = 
        [NSRegularExpression regularExpressionWithPattern:NSSTRING_FORMAT(@"%@-(.*)[0-9]+", filename)
                                                  options:0 
                                                    error:nil];
    NSDictionary *framesPList = [NSPropertyUtil loadProperties:plistFilename];
    for (NSString *key in [framesPList objectForKey:@"frames"]) {
        NSTextCheckingResult *result = [regex firstMatchInString:key options:0 range:NSMakeRange(0, [key length])];
        NSString *frameKey = [key substringWithRange:[result rangeAtIndex:1]]; //0 is the whole string, 1 is the capture group
        [spriteSheet.numOfFramesForKey incrementNumberForKey:frameKey];
    }
    return spriteSheet;
}


- (NSUInteger) getNumOfFramesForKey:(NSString *) key {
	return [[self.numOfFramesForKey objectForKey:key] intValue];
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

- (void) changeSprite:(CCSprite *) sprite   
                toKey:(NSString *) key 
             frameNum:(NSUInteger) frameNum {
    CCSpriteFrame *frame = [self getFrameForKey:key frameNum:frameNum];
    [sprite setTextureRect:frame.rect];
}

- (CCSpriteFrame *) getFrameForKey:(NSString *) key frameNum:(NSUInteger) frameNum {
    NSString *frameKey = NSSTRING_FORMAT(@"%@-%@%d", textureName, key, frameNum);
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameKey];
    return frame;
}

- (CCSprite *) getSpriteForKey:(NSString *) key frameNum:(NSUInteger) frameNum {
    return [CCSprite spriteWithSpriteFrame:[self getFrameForKey:key frameNum:frameNum]];
}

-(void) dealloc {
    [texture release];
    [numOfFramesForKey release];
    [textureName release];
    [super dealloc];
}
@end
