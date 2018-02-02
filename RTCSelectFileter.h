//
//  RTCSelectFileter.h
//  RTCSDK
//
//  Created by ymluo on 2018/1/22.
//  Copyright © 2018年 ymluo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPUImageView;
@class GPUImageMovie;
@class GPUImageBufferRefOutput;
@interface RTCSelectFileter : NSObject
- (void)selectFIleterWithIndx:(NSInteger)index input:(GPUImageMovie*) movieInput outputView:(GPUImageView*)imageView outputBuffer:(GPUImageBufferRefOutput*)bufferOutput;
@end
