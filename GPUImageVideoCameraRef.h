//
//  GPUImageVideoCameraRef.h
//  GPUImage
//
//  Created by ymluo on 2018/1/17.
//  Copyright © 2018年 Brad Larson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "GPUImageContext.h"
#import "GPUImageOutput.h"
#import "GPUImageColorConversion.h"
//Optionally override the YUV to RGB matrices
void setColorConversion601f( GLfloat conversionMatrix[9] );
void setColorConversion601FullRangef( GLfloat conversionMatrix[9] );
void setColorConversion709f( GLfloat conversionMatrix[9] );
@interface GPUImageVideoCameraRef : GPUImageOutput{
    NSUInteger numberOfFramesCaptured;
    CGFloat totalFrameTimeDuringCapture;
    
    
    BOOL capturePaused;
    GPUImageRotationMode outputRotation, internalRotation;
    dispatch_semaphore_t frameRenderingSemaphore;
    
    BOOL captureAsYUV;
    GLuint luminanceTexture, chrominanceTexture;

}
/// This enables the benchmarking mode, which logs out instantaneous and average frame times to the console
@property(readwrite, nonatomic) BOOL runBenchmark;
/// These properties determine whether or not the two camera orientations should be mirrored. By default, both are NO.
@property(readwrite, nonatomic) BOOL horizontallyMirrorFrontFacingCamera, horizontallyMirrorRearFacingCamera;
- (id)initWithCameraVideoOutput:(AVCaptureVideoDataOutput*)videoOutput;
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;
/** Process a video sample
 @param sampleBuffer Buffer to process
 */
- (void)processVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;

/** Process an audio sample
 @param sampleBuffer Buffer to process
 */
- (void)processAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer;
@end
