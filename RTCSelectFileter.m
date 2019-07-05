//
//  RTCSelectFileter.m
//  RTCSDK
//
//  Created by ymluo on 2018/1/22.
//  Copyright © 2018年 ymluo. All rights reserved.
//

#import "RTCSelectFileter.h"

@implementation RTCSelectFileter
-(void)selectFIleterWithIndx:(NSInteger)index input:(GPUImageMovie *)movieInput outputView:(GPUImageView *)imageView outputBuffer:(GPUImageBufferRefOutput *)bufferOutput{
    switch (index) {
//            [logMsgArr addObject:@"默认"];
//            [logMsgArr addObject:@"美颜"];
//            [logMsgArr addObject:@"色彩直方图"];
//            [logMsgArr addObject:@"鱼眼效果"];
            
//            [logMsgArr addObject:@"凹面镜效果"];
//            [logMsgArr addObject:@"哈哈镜"];
//            [logMsgArr addObject:@"浮雕效果"];
//            [logMsgArr addObject:@"图形倒立"];
//            [logMsgArr addObject:@"卡通效果"];
        case 0:{
            GPUImageFilter *file = [[GPUImageFilter alloc]init];
//            file.brightness = -0.5;
            [file useNextFrameForImageCapture];
            [movieInput addTarget:file];
            [file addTarget:imageView];
            [file addTarget:bufferOutput];
        }
            break;
        case 1:{
            GPUImageBeautifyFilter *beautifyFilter =  [[GPUImageBeautifyFilter alloc]init];
            [beautifyFilter useNextFrameForImageCapture];
            [movieInput addTarget:beautifyFilter];
            [beautifyFilter addTarget:bufferOutput];
            [beautifyFilter addTarget:imageView];
        }
            break;
        case 2:{
            GPUImageToneCurveFilter *HistogramGenerator =  [[GPUImageToneCurveFilter alloc]init];
            [HistogramGenerator useNextFrameForImageCapture];
            [movieInput addTarget:HistogramGenerator];
            [HistogramGenerator addTarget:imageView];
            [HistogramGenerator addTarget:bufferOutput];
            
        }
            break;
        case 3:{
            GPUImageBulgeDistortionFilter *BulgeDistortionFilter =  [[GPUImageBulgeDistortionFilter alloc]init];
            [BulgeDistortionFilter useNextFrameForImageCapture];
            [movieInput addTarget:BulgeDistortionFilter];
            [BulgeDistortionFilter addTarget:imageView];
            [BulgeDistortionFilter addTarget:bufferOutput];
        }
            break;
        case 4:{
            GPUImagePinchDistortionFilter *PinchDistortionFilter =  [[GPUImagePinchDistortionFilter alloc]init];
            [PinchDistortionFilter useNextFrameForImageCapture];
            [movieInput addTarget:PinchDistortionFilter];
            [PinchDistortionFilter addTarget:imageView];
            [PinchDistortionFilter addTarget:bufferOutput];
        }
            break;
        case 5:{
            GPUImageStretchDistortionFilter *StretchDistortionFilter =  [[GPUImageStretchDistortionFilter alloc]init];
            [StretchDistortionFilter useNextFrameForImageCapture];
            [movieInput addTarget:StretchDistortionFilter];
            [StretchDistortionFilter addTarget:imageView];
            [StretchDistortionFilter addTarget:bufferOutput];
        }
            break;
        case 6:{
            GPUImageEmbossFilter *EmbossFilter =  [[GPUImageEmbossFilter alloc]init];
            EmbossFilter.intensity = 3.0;
            [EmbossFilter useNextFrameForImageCapture];
            [movieInput addTarget:EmbossFilter];
            [EmbossFilter addTarget:imageView];
            [EmbossFilter addTarget:bufferOutput];
        }
            break;
        case 7:{
            GPUImageSphereRefractionFilter *SphereRefractionFilter =  [[GPUImageSphereRefractionFilter alloc]init];
            [SphereRefractionFilter useNextFrameForImageCapture];
            [movieInput addTarget:SphereRefractionFilter];
            [SphereRefractionFilter addTarget:imageView];
            [SphereRefractionFilter addTarget:bufferOutput];
        }
            break;
        case 8:{
            GPUImageToonFilter *toomFilter =  [[GPUImageToonFilter alloc]init];
            [toomFilter useNextFrameForImageCapture];
            [movieInput addTarget:toomFilter];
            [toomFilter addTarget:imageView];
            [toomFilter addTarget:bufferOutput];
        }
            break;
        default:
            break;
    }
}

@end
