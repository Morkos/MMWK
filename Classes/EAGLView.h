//
//  EAGLView.h
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

// This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
// The view content is basically an EAGL surface you render your OpenGL scene into.
// Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
@interface EAGLView : UIView
{
@private
    EAGLContext *context;
    
    // The pixel dimensions of the CAEAGLLayer.
    GLint framebufferWidth;
    GLint framebufferHeight;
    
    // The OpenGL ES names for the framebuffer and renderbuffer used to render to this view.
    GLuint defaultFramebuffer; 
	GLuint colorRenderbuffer;
	GLuint depthRenderBuffer;
}

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, readonly) GLint framebufferWidth, framebufferHeight;

- (void)setFramebuffer;
- (BOOL)presentFramebuffer;

@end
