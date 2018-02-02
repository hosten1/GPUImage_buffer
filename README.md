# GPUImage_buffer


setup 1:创建
```
        if (capturer) {
         
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
            GPUImageBufferRefOutput *bufferOutput = [[GPUImageBufferRefOutput alloc]initWithVideoSize:CGSizeMake(width, height)];
            _bufferRefOutput = bufferOutput;
            bufferOutput.delegate = self;
            //该类 见setup2
            [[[RTCSelectFileter alloc ]init] selectFIleterWithIndx:_index input:cameraRef outputView:_sampleGpuView outputBuffer:bufferOutput];
            
            [cameraRef processMovieFrame:sampleBuffer];
            
        }
```
setup 2:[RTCSelectFileter](https://github.com/hosten1/GPUImage_buffer/blob/master/RTCSelectFileter.h)
```
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
-(void)imageBufferRefOutputCompletedWithPixelBufferRef:(CVPixelBufferRef)pixelBufferRef{
    if(!_toPixelBuffer){
        DotEnginePixelBuffer *toPixelBuffer = [[DotEnginePixelBuffer alloc]init];
        _toPixelBuffer = toPixelBuffer;
    }
    CVPixelBufferRef convertPixBuffer = [_toPixelBuffer convertPixelBuffer:pixelBufferRef];
  //接下来 拿去显示吧
  。。。
    
 //这里必须手动释放
CVPixelBufferRelease(convertPixBuffer);
}

```




