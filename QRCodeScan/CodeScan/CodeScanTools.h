//
//  CodeScanTools.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2018/8/17.
//  Copyright © 2018年 singularity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CodeScanHeader.h"



@interface CodeScanTools : NSObject

/**
 验证用户是否开启相机并跳转
 
 @param VC 当前VC
 @param scanVC 要跳转的扫描VC
 */
+ (void)permitCameraWithTarget:(UIViewController *)VC PushScanView:(UIViewController *)scanVC;

/**
 *是否开启系统照明灯
 *@param   opened   是否打开
 */
+ (void)openLight:(BOOL)opened;

/**
 *是否开启系统震动和声音
 *@param   shaked   是否开启震动
 *@param   sounding   是否开启声音
 */
+ (void)openShake:(BOOL)shaked Sound:(BOOL)sounding;


/**
 语音播放文字内容
 */
+ (void)soundsPlayer:(NSString *)soundsStr;


/**
 过渡动画  由内向外扩张
 
 */
+ (CAKeyframeAnimation *)zoomOutAnimation;

/**
 打开系统设置
 */
+ (void)openSystemSettings;

@end
