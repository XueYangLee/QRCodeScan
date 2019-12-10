//
//  QRCodeScanManager.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/9.
//  Copyright © 2019 singularity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "QRCodeScanTools.h"

NS_ASSUME_NONNULL_BEGIN

/** 扫描结果 */
typedef void (^QRCodeScanResult)(NSString *scanResult);

/** 相册二维码照片读取结果 */
typedef void (^PhotoCodeImageReadResult)(NSString *readResult);



@interface QRCodeScanManager : NSObject

/** 开启扫描 */
- (void)sessionStartRunning;
/** 停止扫描 */
- (void)sessionStopRunning;
/** 判读是否在扫描 */
- (BOOL)sessionIsRunning;


/** 光感开关开启照明 */
@property (nonatomic,copy) void (^lightSensationShouldOpen)(BOOL openLight);


/** 初始化方法 并返回扫描结果 */
- (instancetype)initWithPreviewLayerSuperView:(UIView *)superView ScanResult:(QRCodeScanResult)scanResult;

/** 调用相册并读取二维码图片返回读取结果 */
- (void)presentPhotoLibraryReadQRCodeImageWithRooterVC:(UIViewController *)rootVC ReadResult:(PhotoCodeImageReadResult)readResult;

@end

NS_ASSUME_NONNULL_END
