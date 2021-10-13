//
//  QRCodeScanViewController.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/10.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <QRCodeScan/QRCodeScan.h>


@interface QRCodeScanViewController ()

@property (nonatomic,strong) QRCodeScanView *scanView;
@property (nonatomic,strong) QRCodeScanManager *scanManager;

@property (nonatomic,assign) BOOL lightFlash;
@property (nonatomic,assign) BOOL isInput;

@end

@implementation QRCodeScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![self.scanManager sessionIsRunning]) {
        [self.scanManager sessionStartRunning];
        [self.scanView addLineAnimateLoop];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanManager sessionStopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.lightFlash=NO;
    self.isInput=NO;
    
    [self setupNavigationView];
    [self setupScanView];
    [self setupScanMananger];
}

- (void)setupNavigationView{
    self.navigationItem.title=@"二维码/条形码";
    
    UIBarButtonItem *photo=[[UIBarButtonItem alloc]initWithImage:[[UIImage QRCodeImageNamed:@"scan_photo"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(photoClick)];
    UIBarButtonItem *flash=[[UIBarButtonItem alloc]initWithImage:[[UIImage QRCodeImageNamed:@"scan_flash"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(flashClick)];
    self.navigationItem.rightBarButtonItems=@[photo,flash];
}


- (void)setupScanView{
    _scanView=[[QRCodeScanView alloc]initWithFrame:self.view.bounds];
    _scanView.showScanInputExchange=YES;
    [self.view addSubview:_scanView];
    __weak typeof(self) weakSelf=self;
    _scanView.scanViewTransformExchange = ^(ScanViewAnimationTransform transformType) {
        //ScanToInput->需停止扫描session ; InputToScan-> 需开启扫描session
        if (transformType==ScanToInput) {
            weakSelf.isInput=YES;
            [weakSelf.scanManager sessionStopRunning];
        }else{
            weakSelf.isInput=NO;
            [weakSelf.scanManager sessionStartRunning];
        }
    };
    _scanView.textInputResult = ^(NSString * _Nonnull inputResult) {
        [weakSelf QRCodeResult:inputResult];
    };
}

- (void)setupScanMananger{
    __weak typeof(self) weakSelf=self;
    _scanManager=[[QRCodeScanManager alloc]initWithPreviewLayerSuperView:self.view ScanResult:^(NSString * _Nonnull scanResult) {
        
        [QRCodeScanTools openShake:YES Sound:YES];
        if ([weakSelf.scanManager sessionIsRunning]) {
            [weakSelf.scanManager sessionStopRunning];
            [weakSelf.scanView removeLineAnimateLoop];
        }
        [weakSelf QRCodeResult:scanResult];
    }];
}


#pragma mark - 二维码结果
- (void)QRCodeResult:(NSString *)codeResult{
    [QRCodeScanTools alertActionWithTitle:@"扫描结果" Message:[NSString stringWithFormat:@"结果为：%@",codeResult] actionHandler:^(UIAlertAction * _Nonnull action) {
        if (!self.isInput) {
            if (![self.scanManager sessionIsRunning]) {
                [self.scanManager sessionStartRunning];
                [self.scanView addLineAnimateLoop];
            }
        }
        
    } Target:self];
}


#pragma mark - 开灯或关灯
- (void)flashClick{
    self.lightFlash=!self.lightFlash;
    [QRCodeScanTools openLight:self.lightFlash];
}

#pragma mark - 调用相册
- (void)photoClick{
    [self.scanManager presentPhotoLibraryReadQRCodeImageWithRooterVC:self ReadResult:^(NSString * _Nonnull readResult) {
        [self QRCodeResult:readResult];
    }];
}



#pragma mark -通知前后台切换
- (void)appWillEnterBackground{
    if ([self.scanManager sessionIsRunning]) {
        [self.scanManager sessionStopRunning];
        [self.scanView removeLineAnimateLoop];
    }
}

- (void)appWillEnterPlayGround{
    if (![self.scanManager sessionIsRunning]) {
        [self.scanManager sessionStartRunning];
        [self.scanView addLineAnimateLoop];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
