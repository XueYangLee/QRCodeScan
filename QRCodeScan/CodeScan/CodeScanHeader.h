//
//  CodeScanHeader.h
//  QRCodeSCan
//
//  Created by 李雪阳 on 2018/8/17.
//  Copyright © 2018年 singularity. All rights reserved.
//

#ifndef CodeScanHeader_h
#define CodeScanHeader_h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height


//二维码部分扫描框尺寸
#define barBgImgX             12.5*ratio
#define barBgImgY             (44+STATUS_HEIGHT+87)*ratio
#define barBgImgWidth         350*ratio
#define barBgImgHeight        210*ratio
//提示语
#define barTipY               (barBgImgY+barBgImgHeight-barTipHeight)
#define barTipHeight          30*ratio

//扫描条高度
#define kScrollLineHeight   5*ratio

#define kBgAlpha            0.6


static NSString *bgImg_img = @"扫描框";
static NSString *Line_img = @"scanLine";
static NSString *ringPath = @"ring";
static NSString *ringType = @"wav";

#endif /* CodeScanHeader_h */
