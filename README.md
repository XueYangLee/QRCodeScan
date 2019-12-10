# QRCodeScan


![参考](https://github.com/XueYangLee/QRCodeScan/blob/master/screen.GIF)

二维码/条形码的扫描及扫描与输入形式的切换
```
相机扫描
_scanManager=[[QRCodeScanManager alloc]initWithPreviewLayerSuperView:self.view ScanResult:^(NSString * _Nonnull scanResult) {
    
    [QRCodeScanTools openShake:YES Sound:YES];
    if ([weakSelf.scanManager sessionIsRunning]) {
        [weakSelf.scanManager sessionStopRunning];
        [weakSelf.scanView removeLineAnimateLoop];
    }
    [weakSelf QRCodeResult:scanResult];
}];


相册调用
[self.scanManager presentPhotoLibraryReadQRCodeImageWithRooterVC:self ReadResult:^(NSString * _Nonnull readResult) {
    [self QRCodeResult:readResult];
}];

```

二维码的生成
```
生成普通二维码
- (void)setDefaultQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 90, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithDefaultQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" imageViewWidth:100];
    [self.view addSubview:code];
}

生成带图片二维码
- (void)setLogoQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithLogoQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" logoImageName:@"scan_photo" logoScaleToSuperView:0.2];
    [self.view addSubview:code];
}

生成彩色二维码
- (void)setColorQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 310, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithColorQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" backgroundColor:[CIColor blueColor] mainColor:[CIColor yellowColor]];
    [self.view addSubview:code];
}
```


