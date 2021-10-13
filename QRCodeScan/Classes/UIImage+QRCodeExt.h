//
//  UIImage+QRCodeExt.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/9/13.
//  Copyright © 2021 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRCodeExt)

+ (UIImage *)QRCodeImageNamed:(NSString *)imgName;

@end

NS_ASSUME_NONNULL_END
