//
//  UIView+QRCodeExt.h
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/9/13.
//  Copyright © 2021 singularity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (QRCodeExt)

@property (nonatomic, assign) CGSize QRCode_size;
@property (nonatomic, assign) CGFloat QRCode_width;
@property (nonatomic, assign) CGFloat QRCode_height;
@property (nonatomic, assign) CGFloat QRCode_x;
@property (nonatomic, assign) CGFloat QRCode_y;
@property (nonatomic, assign) CGFloat QRCode_centerX;
@property (nonatomic, assign) CGFloat QRCode_centerY;

@property CGFloat QRCode_top;
@property CGFloat QRCode_left;

@property CGFloat QRCode_bottom;
@property CGFloat QRCode_right;

@end

NS_ASSUME_NONNULL_END
