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

#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//字体深黑
#define FONT_COLOR333                    UIColorWithRGBA(51.0f, 51.0f, 51.0f, 1.0f)

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度



/** ---------------扫描所需部分--------------- */

#define QRCode_ratio      [[UIScreen mainScreen] bounds].size.width/375.0

//二维码部分扫描框尺寸
#define QRCode_barBgImgX             15*QRCode_ratio
#define QRCode_barBgImgY             (44+QRCode_STATUS_HEIGHT+87)*QRCode_ratio
#define QRCode_barBgImgWidth         (QRCode_SCREEN_WIDTH - (QRCode_barBgImgX *2))
#define QRCode_barBgImgHeight        210*QRCode_ratio
//提示语
#define QRCode_barTipY               (QRCode_barBgImgY+QRCode_barBgImgHeight-QRCode_barTipHeight)
#define QRCode_barTipHeight          30*QRCode_ratio
//输入框高度
#define QRCode_inputTextHeight       45

//扫描条高度
#define QRCode_scrollLineHeight   5*QRCode_ratio

#define QRCode_bgAlpha            0.6


static NSString *ringPath = @"ring";
static NSString *ringType = @"wav";

/** ---------------扫描所需部分--------------- */



#endif /* QRCodeScanHeader_h */
