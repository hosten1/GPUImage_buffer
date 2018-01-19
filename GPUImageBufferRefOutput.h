//
//  GPUImageBufferRefOutput.h
//  GPUImage
//
//  Created by ymluo on 2018/1/18.
//  Copyright © 2018年 Brad Larson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "GPUImageContext.h"

@protocol GPUImageBufferRefOutputDelegate <NSObject>

- (void)imageBufferRefOutputCompletedWithPixelBufferRef:(CVPixelBufferRef)pixelBufferRef;

@end
@interface GPUImageBufferRefOutput :NSObject <GPUImageInput>
@property(nonatomic, assign) id<GPUImageBufferRefOutputDelegate> delegate;
@property(nonatomic, retain) GPUImageContext *movieWriterContext;

-(instancetype)initWithVideoSize:(CGSize)buffVideoSize;
@end
