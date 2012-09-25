//
//  NodeConnector.h
//  DragonEye
//
//  Created by mac on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinePoints.h"
#import "Texture.h"
#import "Node.h"
#import "CoordinateSystem.h"
#import "PolarCoordinates.h"

/**
 * A graphics object that acts as connectors between node overlays
 */
@interface NodeConnector : NSObject<Drawable> {
    LinePoints *line;
    Texture *image;
    CGSize size;
    CGFloat angle;
}

@property (nonatomic, retain) LinePoints *line;
@property (nonatomic, retain) Texture *image;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat angle;

+ (NodeConnector *) createFromStart:(Node *) startNode
                             toNode:(Node *) endNode
                              image:(Texture *) image
                               size:(CGSize) size;

-(void) draw;
-(void) update;

@end
