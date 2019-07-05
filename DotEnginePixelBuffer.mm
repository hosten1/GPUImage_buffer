//
//  DotEnginePixelBufferConvert.m
//  dot-engine-ios
//
//  Created by xiang on 15/01/2017.
//  Copyright © 2017 dotEngine. All rights reserved.
//

#import "DotEnginePixelBuffer.h"
#import <CoreVideo/CoreVideo.h>
#import <libyuv/libyuv.h>
@implementation DotEnginePixelBuffer


- (CVPixelBufferRef)convertPixelBuffer:(CVPixelBufferRef)pixelBuffer{
    
    OSType pixelFormatType = CVPixelBufferGetPixelFormatType(pixelBuffer);
    
    
     if (pixelFormatType == kCVPixelFormatType_32BGRA) {
         // argb   it is a little confused
         
         CVPixelBufferLockBaseAddress(pixelBuffer, 0);
         
         int width = (int)CVPixelBufferGetWidth(pixelBuffer);
         int height = (int)CVPixelBufferGetHeight(pixelBuffer);
         
         int half_width = (width + 1) / 2;
         int half_height = (height + 1) / 2;
         
         const int y_size = width * height;
         const int uv_size = half_width * half_height * 2 ;
         const size_t total_size = y_size + uv_size;
         
         uint8_t* outputBytes = (uint8_t*)calloc(1,total_size);
         
         uint8_t* interMiediateBytes = (uint8_t*)calloc(1,total_size);
         
         uint8_t *srcAddress = (uint8_t*)CVPixelBufferGetBaseAddress(pixelBuffer);
         
         
         libyuv::ARGBToI420(srcAddress,
                    width * 4,
                    interMiediateBytes,
                    half_width * 2,
                    interMiediateBytes + y_size,
                    half_width,
                    interMiediateBytes + y_size + y_size/4,
                    half_width,
                    width, height);
         
          libyuv::I420ToNV12(interMiediateBytes,
                    half_width * 2,
                    interMiediateBytes + y_size,
                    half_width,
                    interMiediateBytes + y_size + y_size/4,
                    half_width,
                    outputBytes,
                    half_width * 2,
                    outputBytes + y_size,
                    half_width * 2,
                    width, height);
         
         free(interMiediateBytes);
         
         CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
         
         CVPixelBufferRef pixel_buffer = NULL;
         
         CVPixelBufferCreate(kCFAllocatorDefault, width , height,
                             kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
                             NULL, &pixel_buffer);
         
         CVPixelBufferLockBaseAddress(pixel_buffer, 0);
         
         void * plan1 = CVPixelBufferGetBaseAddressOfPlane(pixel_buffer,0);
         size_t  plan1_height = CVPixelBufferGetHeightOfPlane(pixel_buffer,0);
         size_t  plan1_sizePerRow = CVPixelBufferGetBytesPerRowOfPlane(pixel_buffer,0);
         
         memcpy(plan1, outputBytes, plan1_height * plan1_sizePerRow);
         
         void * plan2 = CVPixelBufferGetBaseAddressOfPlane(pixel_buffer,1);
         size_t  plan2_height = CVPixelBufferGetHeightOfPlane(pixel_buffer,1);
         size_t  plan2_sizePerRow = CVPixelBufferGetBytesPerRowOfPlane(pixel_buffer,1);
         
         memcpy(plan2, outputBytes +  plan1_height * plan1_sizePerRow, plan2_height * plan2_sizePerRow);
         
         CVPixelBufferUnlockBaseAddress(pixel_buffer, 0);
         
         free(outputBytes);
         
         return pixel_buffer;
     
     } else if(pixelFormatType == kCVPixelFormatType_420YpCbCr8PlanarFullRange) {
         // i420
         
         NSLog(@"send kCVPixelFormatType_420YpCbCr8PlanarFullRange");
         
         
         CVPixelBufferLockBaseAddress(pixelBuffer, 0);
         
         int width = (int)CVPixelBufferGetWidth(pixelBuffer);
         int height = (int)CVPixelBufferGetHeight(pixelBuffer);
         
         int half_width = (width + 1) / 2;
         int half_height = (height + 1) / 2;
         
         const int y_size = width * height;
         const int uv_size = half_width * half_height * 2 ;
         const size_t total_size = y_size + uv_size;
         
         uint8_t* outputBytes = (uint8_t*)calloc(1,total_size);
         
//         uint8_t* srcBase = (uint8_t*)CVPixelBufferGetBaseAddress(pixelBuffer);
         uint8_t* tempS = (uint8_t*)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
         uint8_t* tempS1 = (uint8_t*) CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
         uint8_t* tempS2 = (uint8_t*)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 2);
         libyuv::I420ToNV12(tempS,
                    half_width * 2,
                    tempS1,
                    half_width,
                    tempS2,
                    half_width,
                    outputBytes,
                    half_width * 2,
                    outputBytes + y_size,
                    half_width * 2,
                    width, height);
         
         CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
         
         CVPixelBufferRef pixel_buffer = NULL;
         
         CVPixelBufferCreate(kCFAllocatorDefault, width , height,
                             kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
                             NULL, &pixel_buffer);
         
         CVPixelBufferLockBaseAddress(pixel_buffer, 0);
         
         void * plan1 = CVPixelBufferGetBaseAddressOfPlane(pixel_buffer,0);
         size_t  plan1_height = CVPixelBufferGetHeightOfPlane(pixel_buffer,0);
         size_t  plan1_sizePerRow = CVPixelBufferGetBytesPerRowOfPlane(pixel_buffer,0);
         
         memcpy(plan1, outputBytes, plan1_height * plan1_sizePerRow);
         
         void * plan2 = CVPixelBufferGetBaseAddressOfPlane(pixel_buffer,1);
         size_t  plan2_height = CVPixelBufferGetHeightOfPlane(pixel_buffer,1);
         size_t  plan2_sizePerRow = CVPixelBufferGetBytesPerRowOfPlane(pixel_buffer,1);
         
         memcpy(plan2, outputBytes +  plan1_height * plan1_sizePerRow, plan2_height * plan2_sizePerRow);
         
         CVPixelBufferUnlockBaseAddress(pixel_buffer, 0);
         
         free(outputBytes);
         
         return pixel_buffer;
         
     }
    
    return NULL;
}


@end
