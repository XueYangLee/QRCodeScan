//
//  XYViewController.m
//  QRCodeScan
//
//  Created by Singularity_Lee on 10/12/2021.
//  Copyright (c) 2021 Singularity_Lee. All rights reserved.
//

#import "XYViewController.h"
#import "CodeGenerateViewController.h"
#import "QRCodeScanViewController.h"
#import <QRCodeScan/QRCodeScan.h>

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad
{
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
