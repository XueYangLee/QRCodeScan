//
//  QRCodeScanManager.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/9.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "QRCodeScanManager.h"
#import "QRCodeScanHeader.h"


@interface QRCodeScanManager ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**输入输出中间桥梁(会话)*/
@property (nonatomic,strong) AVCaptureSession *session;

/** 扫描结果 */
@property (nonatomic,copy) QRCodeScanResult scanResult;
/** 相册二维码照片读取结果 */
@property (nonatomic,copy) PhotoCodeImageReadResult readResult;

@end



@implementation QRCodeScanManager


- (instancetype)initWithPreviewLayerSuperView:(UIView *)superView ScanResult:(QRCodeScanResult)scanResult{
    self=[super init];
    if (self) {
        self.scanResult=scanResult;
        [self setupVideoPreviewLayerWithSuperView:superView];
    }
    return self;
}


#pragma mark -创建预览图层/扫描图层  *优先调用
- (void)setupVideoPreviewLayerWithSuperView:(UIView *)superView{
    //创建预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    previewLayer.frame = superView.bounds;
    [superView.layer insertSublayer:previewLayer atIndex:0];
    //[previewLayer addAnimation:[QRCodeScanTools zoomOutAnimation] forKey:nil];//添加过渡动画，类似微信
    

    //缩放手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [superView addGestureRecognizer:pinchGesture];
}


#pragma mark -相机调用
- (AVCaptureSession *)session {
    if (!_session) {
        //1.获取输入设备（摄像头）
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        //2.根据输入设备创建输入对象
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
        if (input == nil) {
            return nil;
        }
        
        //3.创建元数据的输出对象
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        //4.设置代理监听输出对象输出的数据,在主线程中刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 创建环境光感输出流
        AVCaptureVideoDataOutput *lightOutput = [[AVCaptureVideoDataOutput alloc] init];
        [lightOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
        
        // 5.创建会话(桥梁)
        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        //实现高质量的输出和摄像，默认值为AVCaptureSessionPresetHigh，可以不写
        //AVCaptureSessionPreset1920x1080 对于小型的二维码读取率较高
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
        // 6.添加输入和输出到会话中（判断session是否已满）
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        if ([session canAddOutput:lightOutput]) {
            [session addOutput:lightOutput];
        }
        
        // 7.告诉输出对象, 需要输出什么样的数据 (二维码还是条形码等) 要先创建会话才能设置
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode];
        
        //8.设置有效扫描区域，默认整个图层(很特别，1、要除以屏幕宽高比例，2、其中x和y、width和height分别互换位置)
        //rectOfInterest 填写的是一个比例，输出流视图preview.frame为 x , y, w, h, 要设置的矩形快的scanFrame 为 x1, y1, w1, h1. 那么rectOfInterest 应该设置为 CGRectMake(y1/y, x1/x, h1/h, w1/w)。
        CGRect rect = CGRectMake(QRCode_barBgImgY/QRCode_SCREEN_HEIGHT, QRCode_barBgImgX/QRCode_SCREEN_WIDTH, QRCode_barBgImgHeight/QRCode_SCREEN_HEIGHT, QRCode_barBgImgWidth/QRCode_SCREEN_WIDTH);
        //CGRect rect = CGRectMake(0, 0, 0, 0);
        output.rectOfInterest = rect;
        
        _session = session;
    }
    return _session;
}

/** 开始扫描 */
- (void)sessionStartRunning{
    if (!self.session.isRunning) {
        [self.session startRunning];
    }
}
/** 停止扫描 */
- (void)sessionStopRunning{
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}
/** 判断是否在扫描中 */
- (BOOL)sessionIsRunning{
    return self.session.isRunning;
}


#pragma mark -扫描获取扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        /*
        [QRCodeScanTools openShake:YES Sound:YES];
        // 1.停止扫描
        [self.session stopRunning];
        // 2.停止扫描线运动
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];*/
        
        // 3.取出扫描到得数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        if (obj) {
            //二维码信息回传
            //NSLog(@">>>>>>>>>>>>%@>>>>",[obj stringValue]);
            if (self.scanResult) {
                self.scanResult([obj stringValue]);
            }

        }
    }
}


#pragma mark -扫描中判断环境的黑暗程度
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    if (self.lightSensationShouldOpen == nil) {
        return;
    }
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    //    NSLog(@"环境光感 ： %f",brightnessValue);
    
    // 根据brightnessValue的值来判断是否需要打开和关闭闪光灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL result = [device hasTorch];// 判断设备是否有闪光灯
    if ((brightnessValue < 0) && result) {
        // 环境太暗，可以打开闪光灯了
        if (self.lightSensationShouldOpen) {
            self.lightSensationShouldOpen(YES);
        }
    }else if((brightnessValue > 0) && result){
        // 环境亮度可以
        if (self.lightSensationShouldOpen) {
            self.lightSensationShouldOpen(NO);
        }
    }
    
}

#pragma mark -缩放手势
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    CGFloat minZoomFactor = 1.0;
    CGFloat maxZoomFactor = device.activeFormat.videoMaxZoomFactor;
    
    if (@available(iOS 11.0, *)) {
        minZoomFactor = device.minAvailableVideoZoomFactor;
        maxZoomFactor = device.maxAvailableVideoZoomFactor;
    }
    
    static CGFloat lastZoomFactor = 1.0;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastZoomFactor = device.videoZoomFactor;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat zoomFactor = lastZoomFactor * gesture.scale;
        zoomFactor = fmaxf(fminf(zoomFactor, maxZoomFactor), minZoomFactor);
        [device lockForConfiguration:nil];
        device.videoZoomFactor = zoomFactor;
        [device unlockForConfiguration];
    }
}



#pragma mark -相册调用 读取相册中的二维码图片
- (void)presentPhotoLibraryReadQRCodeImageWithRooterVC:(UIViewController *)rootVC ReadResult:(PhotoCodeImageReadResult)readResult{
    self.readResult=readResult;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [rootVC presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [QRCodeScanTools showAlert:@"不支持访问相册" Target:rootVC];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *pickedImage = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    CIImage *codeImage = [CIImage imageWithData:UIImagePNGRepresentation(pickedImage)];
//    CIImage *codeImage = [CIImage imageWithCGImage:pickedImage.CGImage];
    
    CIContext *codeContext = [CIContext contextWithOptions:nil];
    //检测图片中的二维码，并设置检测精度为高
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:codeContext options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
    //读取图片的qrcode特性 获取识别结果
    NSArray *features = [detector featuresInImage:codeImage options:nil];
    //返回的结果，只读取一条
    NSString *resultString=@"";
    if (features && features.count > 0) {
        for (CIQRCodeFeature *codeFeature in features) {
            if (resultString.length > 0) {
                break;
            }
            resultString = codeFeature.messageString;
        }
    }else{
        NSLog(@"无法识别图中二维码");
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.readResult) {
            self.readResult(resultString);
        }
    }];
}



@end
