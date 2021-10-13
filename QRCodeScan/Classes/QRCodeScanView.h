//
//  QRCodeScanView.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/10.
//  Copyright © 2019 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+QRCodeExt.h"
#import "UIImage+QRCodeExt.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ScanToInput,//扫描切换至输入
    InputToScan,//输入切换至扫描
} ScanViewAnimationTransform;

@interface QRCodeScanView : UIView

/** 是否显示扫描输入切换按钮 默认NO */
@property (nonatomic,assign) BOOL showScanInputExchange;

/** 添加并开启扫描线运动动画 */
- (void)addLineAnimateLoop;
/** 停止并移除扫描线运动动画 */
- (void)removeLineAnimateLoop;

/** 文本输入结果 */
@property (nonatomic,copy) void (^textInputResult)(NSString *inputResult);

/** 扫描输入样式切换   ScanToInput->需停止扫描session ; InputToScan-> 需开启扫描session  */
@property (nonatomic,copy) void (^scanViewTransformExchange)(ScanViewAnimationTransform transformType);

@end

NS_ASSUME_NONNULL_END
