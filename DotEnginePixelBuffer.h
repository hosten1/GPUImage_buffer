//
//  DotEnginePixelBufferConvert.h
//  dot-engine-ios
//
//  Created by xiang on 15/01/2017.
//  Copyright © 2017 dotEngine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DotEnginePixelBuffer : NSObject

- (CVPixelBufferRef)convertPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
