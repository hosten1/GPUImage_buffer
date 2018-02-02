# GPUImage_buffer

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
            
            [[[RTCSelectFileter alloc ]init] selectFIleterWithIndx:_index input:cameraRef outputView:_sampleGpuView outputBuffer:bufferOutput];
            
            [cameraRef processMovieFrame:sampleBuffer];
            
        }
```
setup 2:RTCSelectFileter
```
GPUImageBeautifyFilter *beautifyFilter =  [[GPUImageBeautifyFilter alloc]init];
            [beautifyFilter useNextFrameForImageCapture];
            [movieInput addTarget:beautifyFilter];
            [beautifyFilter addTarget:bufferOutput];
            [beautifyFilter addTarget:imageView];
```

