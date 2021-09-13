//
//  ViewController.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2018/9/3.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeScanHeader.h"
#import "QRCodeScanTools.h"
#import "CodeGenerateViewController.h"
#import "QRCodeScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, i*50+100, QRCode_SCREEN_WIDTH, 40)];
        [btn setTitle:i==0?@"二维码/条形码扫描":@"生成二维码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor lightGrayColor];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


#warning 不要忘记plist文件设置权限
- (void)btnClick:(UIButton *)sender{
    if (sender.tag==0) {
        [QRCodeScanTools permitCameraWithTarget:self PushScanView:[QRCodeScanViewController new]];
    }else{
        [self.navigationController pushViewController:[CodeGenerateViewController new] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
