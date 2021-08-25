//
//  GPUImageBufferRefOutput.m
//  GPUImage
//
//  Created by ymluo on 2018/1/18.
//  Copyright © 2018年 Brad Larson. All rights reserved.
//

#import "GPUImageBufferRefOutput.h"
#import "GPUImageContext.h"
#import "GLProgram.h"
#import "GPUImageFilter.h"

@interface GPUImageBufferRefOutput(){
   GPUImageFramebuffer *firstInputFramebuffer;
    
}
@end

@implementation GPUImageBufferRefOutput
-(instancetype)initWithVideoSize:(CGSize)buffVideoSize{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark GPUImageInput protocol

- (void)newFrameReadyAtTime:(CMTime)frameTime atIndex:(NSInteger)textureIndex;
{
    if (firstInputFramebuffer) {
        CVPixelBufferRef bufferRef = [firstInputFramebuffer pixelBuffer];
        if (!bufferRef) {
            [firstInputFramebuffer unlock];
            return;
        }
        if (_delegate && [_delegate respondsToSelector:@selector(imageBufferRefOutputCompletedWithPixelBufferRef:)]) {
            [_delegate imageBufferRefOutputCompletedWithPixelBufferRef:bufferRef];
        }
        [firstInputFramebuffer unlock];
    }
}

- (NSInteger)nextAvailableTextureIndex;
{
    return 0;
}

- (void)setInputFramebuffer:(GPUImageFramebuffer *)newInputFramebuffer atIndex:(NSInteger)textureIndex;
{
    if (newInputFramebuffer) {
        [newInputFramebuffer lock];
        //    runSynchronouslyOnContextQueue(_movieWriterContext, ^{
        firstInputFramebuffer = newInputFramebuffer;
        //    });
    }
  
}
- (void)setInputRotation:(GPUImageRotationMode)newInputRotation atIndex:(NSInteger)textureIndex;
{
//    inputRotation = newInputRotation;
}

- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex;
{
}



- (void)setCurrentlyReceivingMonochromeInput:(BOOL)newValue;
{
    
}
- (CGSize)maximumOutputSize{
    return CGSizeZero;
}
- (void)endProcessing{
    
}
- (BOOL)shouldIgnoreUpdatesToThisTarget{
    return NO;
}
- (BOOL)enabled{
    return NO;
}
- (BOOL)wantsMonochromeInput{
    return NO;
}
@end
