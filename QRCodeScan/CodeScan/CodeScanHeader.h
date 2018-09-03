//
//  CodeScanHeader.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2018/8/17.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import "UIView+Extension.h"

#ifndef CodeScanHeader_h
#define CodeScanHeader_h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//字体深黑
#define FONT_COLOR333                    UIColorWithRGBA(51.0f, 51.0f, 51.0f, 1.0f)

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度



/** ---------------扫描所需部分--------------- */

#define ratio      [[UIScreen mainScreen] bounds].size.width/375.0

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

/** ---------------扫描所需部分--------------- */

#endif /* CodeScanHeader_h */
