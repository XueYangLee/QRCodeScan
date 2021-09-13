//
//  QRCodeScanHeader.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/9.
//  Copyright © 2019 singularity. All rights reserved.
//

#ifndef QRCodeScanHeader_h
#define QRCodeScanHeader_h



#define QRCode_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define QRCode_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define QRCode_STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define QRCode_UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//字体深黑
#define QRCode_BLACK_COLOR                    QRCode_UIColorWithRGBA(51.0f, 51.0f, 51.0f, 1.0f)

#define QRCode_MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define QRCode_MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度



/** ---------------扫描所需部分--------------- */

#define QRCode_RATIO      [[UIScreen mainScreen] bounds].size.width/375.0

//二维码部分扫描框尺寸
#define QRCode_BarBGImgX             15*QRCode_RATIO
#define QRCode_BarBGImgY             (44+QRCode_STATUS_HEIGHT+87)*QRCode_RATIO
#define QRCode_BarBGImgWidth         (QRCode_SCREEN_WIDTH - (QRCode_BarBGImgX *2))
#define QRCode_BarBGImgHeight        210*QRCode_RATIO
//提示语
#define QRCode_BarTipY               (QRCode_BarBGImgY+QRCode_BarBGImgHeight-QRCode_BarTipHeight)
#define QRCode_BarTipHeight          30*QRCode_RATIO
//输入框高度
#define QRCode_InputTextHeight       45

//扫描条高度
#define QRCode_ScrollLineHeight   5*QRCode_RATIO

#define QRCode_BGAlpha            0.6


static NSString *ringPath = @"ring";
static NSString *ringType = @"wav";

/** ---------------扫描所需部分--------------- */



#endif /* QRCodeScanHeader_h */
