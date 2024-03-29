//
//  CodeGenerateViewController.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2018/9/3.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "CodeGenerateViewController.h"
#import <QRCodeScan/QRCodeScan.h>

@interface CodeGenerateViewController ()

@end

@implementation CodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setDefaultQRCode];
    [self setLogoQRCode];
    [self setColorQRCode];
}


- (void)setDefaultQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 90, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithDefaultQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" imageViewWidth:100];
    [self.view addSubview:code];
}

- (void)setLogoQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithLogoQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" logoImageName:@"scan_photo" logoScaleToSuperView:0.2];
    [self.view addSubview:code];
}

- (void)setColorQRCode{
    UIImageView *code=[[UIImageView alloc]initWithFrame:CGRectMake(10, 310, 100, 100)];
    code.image=[QRCodeGenerateTools generateWithColorQRCodeData:@"https://github.com/XueYangLee/QRCodeScan" backgroundColor:[CIColor blueColor] mainColor:[CIColor yellowColor]];
    [self.view addSubview:code];
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
