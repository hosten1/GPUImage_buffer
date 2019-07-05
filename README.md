# GPUImage_buffe
setup 1:创建
```objectivec
//WebRTC 返回的摄像头采集数据
@property(nonatomic,strong) GPUImageBufferRefOutput *outputBuffer;
      [self.capturer onOutputSampleBufferCB:^(AVCaptureOutput * _Nonnull captureOutput, CMSampleBufferRef  _Nonnull sampleBuffer, AVCaptureConnection * _Nonnull connection) {
          weakSelf.CaptureOutput = captureOutput;
          weakSelf.CaptureConnection = connection;
          weakSelf.sampleBuffer = sampleBuffer;
          CVImageBufferRef bufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
          //        _CaptureOutput = captureOutput;
          //        _CaptureConnection = connection;
          //        _sampleBuffer = sampleBuffer;
          //        NSLog(@"hosten current Threat %@",[NSThread currentThread]);
          CVPixelBufferLockBaseAddress(bufferRef, 0);
          
          size_t width,height;
          //图片每一行的大小
          if (CVPixelBufferIsPlanar(bufferRef)) {
              width = CVPixelBufferGetWidthOfPlane(bufferRef,0);
              height = CVPixelBufferGetHeightOfPlane(bufferRef,0);
          }else{
              width = CVPixelBufferGetWidth(bufferRef);
              height = CVPixelBufferGetHeight(bufferRef);
          }
          CVPixelBufferUnlockBaseAddress(bufferRef, 0);
          GPUImageMovie *cameraRef = [[GPUImageMovie alloc]initWithAsset:nil];
          
          weakSelf.outputBuffer = [[GPUImageBufferRefOutput alloc]initWithVideoSize:CGSizeMake(width, height)];
          weakSelf.outputBuffer.delegate = weakSelf;
          GPUImageBeautifyFilter *beautifyFilter =  [[GPUImageBeautifyFilter alloc]init];
          [beautifyFilter useNextFrameForImageCapture];
          
          [cameraRef addTarget:beautifyFilter];
          [beautifyFilter addTarget:weakSelf.outputBuffer];
         
//          [beautifyFilter addTarget:imageView];
          [cameraRef processMovieFrame:weakSelf.sampleBuffer];
         
//           [weakSelf.capturer ouputSampleWithcaptureOutput:captureOutput didOutputPixelBuffer:nil fromConnection:connection SampleBuffer:sampleBuffer];
          
      }];
```
setup 2:[RTCSelectFileter](https://github.com/hosten1/GPUImage_buffer/blob/master/RTCSelectFileter.h)
```objectivec
GPUImageBeautifyFilter *beautifyFilter =  [[GPUImageBeautifyFilter alloc]init];
[beautifyFilter useNextFrameForImageCapture];
[movieInput addTarget:beautifyFilter];
[beautifyFilter addTarget:bufferOutput];
//上面的自定义输出有点问题 必须的再加上一个输出才能拿到数据GPUImageView
[beautifyFilter addTarget:imageView];
```
setup 3:关于输出BGRA如果需要,提供一个转yuv文件[DotEnginePixelBuffer](https://github.com/hosten1/GPUImage_buffer/blob/master/DotEnginePixelBuffer.h):

```
  #pragma mark --GPUImageBufferRefOutputDelegate
- (void)imageBufferRefOutputCompletedWithPixelBufferRef:(CVPixelBufferRef)pixelBufferRef {
    OSType pixelFormatType = CVPixelBufferGetPixelFormatType(pixelBufferRef);
    if (pixelFormatType == kCVPixelFormatType_32BGRA || pixelFormatType == kCVPixelFormatType_420YpCbCr8PlanarFullRange) {
        DotEnginePixelBuffer *toPixelBuffer = [[DotEnginePixelBuffer alloc]init];
        CVPixelBufferRef convertPixBuffer = [toPixelBuffer convertPixelBuffer:pixelBufferRef];
        <!--处理完成后返回帧数据到webrtc-->
         [self.capturer ouputSampleWithcaptureOutput:_CaptureOutput didOutputPixelBuffer:convertPixBuffer fromConnection:_CaptureConnection SampleBuffer:_sampleBuffer];
        //这里必须手动释放
        CVPixelBufferRelease(convertPixBuffer);
        
    }
}
```




