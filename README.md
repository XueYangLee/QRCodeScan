# QRCodeScan


![参考](https://github.com/XueYangLee/QRCodeScan/blob/master/screen.GIF)

二维码/条形码的扫描及扫描与输入形式的切换
```
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
    [CodeScanTools openShake:YES Sound:YES];

    [self.session stopRunning];

    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
    if (obj) {
        //二维码信息回传
        //NSLog(@">>>>>>>>>>>>%@>>>>",[obj stringValue]);
        [self scanCodeResult:[obj stringValue]];


        }
    }
}
```

二维码的生成
```
/**
  生成一张普通的二维码
*/
+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth {

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    [filter setDefaults];

    NSString *info = data;

    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];

    [filter setValue:infoData forKeyPath:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];

    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageViewWidth];
}
```


