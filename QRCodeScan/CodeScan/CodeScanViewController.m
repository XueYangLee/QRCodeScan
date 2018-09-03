//
//  CodeScanViewController.m
//  QRCodeSCan
//
//  Created by 李雪阳 on 2018/8/17.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "CodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CodeScanHeader.h"
#import "CodeScanTools.h"

@interface CodeScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**输入输出中间桥梁(会话)*/
@property (strong, nonatomic) AVCaptureSession *session;
/**计时器*/
@property (strong, nonatomic) CADisplayLink *link;
/**实际有效扫描区域的背景图(亦或者自己设置一个边框)*/
@property (strong, nonatomic) UIImageView *bgImg;
/**有效扫描区域循环往返的一条线（这里用的是一个背景图）*/
@property (strong, nonatomic) UIImageView *scrollLine;
/**扫码有效区域外自加的文字提示*/
@property (strong, nonatomic) UILabel *tip;
/**用于记录scrollLine的上下循环状态*/
@property (assign, nonatomic) BOOL up;
/** 遮盖图层 */
@property (nonatomic,weak) CAShapeLayer *shapeLayer;
/** 遮盖视图 */
@property (nonatomic,strong) UIView *maskView;
/** 记录闪光灯点击 */
@property (nonatomic,assign) NSInteger flashIndex;
/** 切换按钮 */
@property (nonatomic,strong) UIButton *switchBtn;
/** 手动输入框 */
@property (nonatomic,strong) UITextField *codeNumText;
@property (nonatomic,strong) UIView *codeTextView;

@end

@implementation CodeScanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    _up = YES;
    _flashIndex=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
