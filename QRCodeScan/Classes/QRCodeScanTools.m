//
//  QRCodeScanTools.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/9.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "QRCodeScanTools.h"
#import "QRCodeBundle.h"

/** app名字 */
#define APP_NAME [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"]
/** 设备类型  返回 iPhone或当前其他设备 */
#define DEVICE_TYPE [UIDevice currentDevice].model
#define kIOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)

@implementation QRCodeScanTools

+ (void)permitCameraWithTarget:(UIViewController *)VC PushScanView:(UIViewController *)scanVC{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {// 用户第一次同意了访问相机权限
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [VC.navigationController pushViewController:scanVC animated:YES];
                    });
                } else {
                    // 用户第一次拒绝了访问相机权限
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self alertActionWithTitle:@"提示" Message:[NSString stringWithFormat:@"请在%@的\"设置-隐私-相机\"选项中，\r允许%@访问你的相机。",DEVICE_TYPE,APP_NAME] actionHandler:^(UIAlertAction *action) {
                            [self openSystemSettings];
                        } Target:VC];
                    });
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            dispatch_async(dispatch_get_main_queue(), ^{
                [VC.navigationController pushViewController:scanVC animated:YES];
            });
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            dispatch_async(dispatch_get_main_queue(), ^{
                [self alertActionWithTitle:@"提示" Message:[NSString stringWithFormat:@"请在%@的\"设置-隐私-相机\"选项中，\r允许%@访问你的相机。",DEVICE_TYPE,APP_NAME] actionHandler:^(UIAlertAction *action) {
                    [self openSystemSettings];
                } Target:VC];
            });
            
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlert:@"未检测到您的摄像头" Target:VC];
        });
    }
}

+ (void)openLight:(BOOL)opened {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    if (![device hasTorch]) {
    } else {
        if (opened) {
            // 开启闪光灯
            if(device.torchMode != AVCaptureTorchModeOn ||
               device.flashMode != AVCaptureFlashModeOn){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
            }
        } else {
            // 关闭闪光灯
            if(device.torchMode != AVCaptureTorchModeOff ||
               device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

+ (void)openShake:(BOOL)shaked Sound:(BOOL)sounding {
    if (shaked) {
        //开启系统震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if (sounding) {
//        AudioServicesPlaySystemSound(1360);//系统声音
        
        //设置自定义声音
        NSString *path = [[QRCodeBundle bundle] pathForResource:@"QRCodeScan" ofType:@"bundle"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"scan_ring.wav"]], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

+ (void)soundsPlayer:(NSString *)soundsStr
{
    if(soundsStr && soundsStr.length > 0){
        AVSpeechSynthesizer *player  = [[AVSpeechSynthesizer alloc]init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:soundsStr];//设置语音内容
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置语言
        //        utterance.rate = 0.1;  //设置语速
        utterance.volume = 1;  //设置音量（0.0~1.0）默认为1.0
        utterance.pitchMultiplier = 1;  //设置语调 (0.5-2.0)
        utterance.postUtteranceDelay = 1; //目的是让语音合成器播放下一语句前有短暂的暂停
        [player speakUtterance:utterance];
    }
}

+ (CAKeyframeAnimation *)zoomOutAnimation {
    CAKeyframeAnimation *animationLayer = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animationLayer.duration = 0.1;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animationLayer.values = values;
    
    return animationLayer;
}


#warning 使用openURL前添加scheme：prefs
+ (void)openSystemSettings {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kIOS8_OR_LATER ? UIApplicationOpenSettingsURLString : @"prefs:root"]];
}





#pragma mark -弹窗
+ (void)alertActionWithTitle:(NSString *)title Message:(NSString *)message actionHandler:(void (^ __nullable)(UIAlertAction *action))handler Target:(UIViewController *)viewController
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:confirm];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showAlert:(NSString *)message Target:(UIViewController *)viewController
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirm];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
