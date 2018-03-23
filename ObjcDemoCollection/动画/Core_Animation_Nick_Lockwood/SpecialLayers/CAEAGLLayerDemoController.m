//
//  CAEAGLLayerDemoController.m
//  ObjcDemoCollection
//
//  Created by jiabaozhang on 2018/1/19.
//  Copyright © 2018年 jiabaozhang. All rights reserved.
//

#import "CAEAGLLayerDemoController.h"
#import <GLKit/GLKit.h>

@interface CAEAGLLayerDemoController ()

@property (nonatomic, strong) UIView *glView;

@end

@implementation CAEAGLLayerDemoController
{
    EAGLContext *_glContext;
    CAEAGLLayer *_glLayer;
    GLuint _framebuffer;
    GLuint _colorRenderbuffer;
    GLint _framebufferWidth;
    GLint _framebufferHeight;
    GLKBaseEffect *_effect;
}

#pragma mark - life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up view
    self.glView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.glView.center = self.view.center;
    self.glView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.glView];
    
    // set up context
    _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:_glContext];
    
    // set up layer
    _glLayer = [CAEAGLLayer layer];
    _glLayer.frame = self.glView.bounds;
    [self.glView.layer addSublayer:_glLayer];
    _glLayer.drawableProperties = @{
                                        kEAGLDrawablePropertyRetainedBacking : @NO,
                                        kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8,
                                        };
    
    //set up base effect
    _effect = [[GLKBaseEffect alloc] init];
    
    //set up buffers
    [self setUpBuffers];
    
    //draw frame
    [self drawFrame];
}

- (void)viewDidUnload
{
    [self tearDownBuffers];
    [super viewDidUnload];
}

- (void)dealloc
{
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}

#pragma mark - private methods: OpenGL Draw View
- (void)setUpBuffers
{
    // frame buffers
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
    // color render buffers
    glGenRenderbuffers(1, &_colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderbuffer);
    [_glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_glLayer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_framebufferHeight);
    
    // check success
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"Failed to make complete framebuffer object: %i", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}

- (void)tearDownBuffers
{
    if (_framebuffer) {
        glDeleteBuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    
    if (_colorRenderbuffer) {
        glDeleteRenderbuffers(1, &_colorRenderbuffer);
        _colorRenderbuffer = 0;
    }
}

- (void)drawFrame
{
    //bind framebuffer & set viewport
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glViewport(0, 0, _framebufferWidth, _framebufferHeight);
    
    //bind shader program
    [_effect prepareToDraw];
    
    //clear the screen
    glClear(GL_COLOR_BUFFER_BIT); glClearColor(0.0, 0.0, 0.0, 1.0);
    
    //set up vertices
    GLfloat vertices[] = {
        -0.5f, -0.5f, -1.0f, 0.0f, 0.5f, -1.0f, 0.5f, -0.5f, -1.0f,
    };
    
    //set up colors
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f,
    };
    
    //draw triangle
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);

    //present render buffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [_glContext presentRenderbuffer:GL_RENDERBUFFER];
}

@end
