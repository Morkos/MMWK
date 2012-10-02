//
//  AttackButton.mm
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AttackButton.h"

static NSTimer * hitTimer;
static NSTimer * liftOffFingerTimer = [[NSTimer alloc] init];
static NSUInteger hitsInSequence = 0;

static BOOL isComboInitiated = false;

@implementation AttackButton

- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	[[ObjectContainer sharedInstance].player attack];
    hitTimer = [NSTimer scheduledTimerWithTimeInterval:TIME_EXPIRE_ON_HOLD_IN_SECONDS
                                                target:self 
                                              selector:@selector(initiateCombo:) 
                                              userInfo:nil 
                                               repeats:NO];
    
    //kill the lift off finger timer, because another touch began.
    if([liftOffFingerTimer isValid]) {
        [liftOffFingerTimer invalidate];
    }
    
    hitsInSequence++;
    [hitTimer retain];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{	
	if ([hitTimer isValid]) {
		[hitTimer invalidate];
	}
    
    liftOffFingerTimer = [NSTimer scheduledTimerWithTimeInterval:TIME_EXPIRE_ON_RELEASE_IN_SECONDS
                                                          target:self 
                                                        selector:@selector(resetHitCount:) 
                                                        userInfo:nil 
                                                         repeats:NO];
    
    //function is going out of scope, but sill need this object around.
    [liftOffFingerTimer retain];
}

- (void)initiateCombo:(NSTimer *)theTimer
{
    isComboInitiated = TRUE;
	NSLog(@"Timer Fired with %d consistent hits", hitsInSequence);
    
    [[ObjectContainer sharedInstance].player initiateComboAttempt:hitsInSequence];
    
    hitsInSequence = 0;
    
}

- (void) resetHitCount:(NSTimer *) theTimer {
    NSLog(@"Resetting consistent hit count.");
    hitsInSequence = 0;
}

@end
