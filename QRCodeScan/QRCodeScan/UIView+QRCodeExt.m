//
//  UIView+QRCodeExt.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/9/13.
//  Copyright © 2021 singularity. All rights reserved.
//

#import "UIView+QRCodeExt.h"

@implementation UIView (QRCodeExt)

- (void)setQRCode_size:(CGSize)QRCode_size
{
    CGRect frame = self.frame;
    frame.size = QRCode_size;
    self.frame = frame;
}

- (CGSize)QRCode_size
{
    return self.frame.size;
}

- (void)setQRCode_width:(CGFloat)QRCode_width
{
    CGRect frame = self.frame;
    frame.size.width = QRCode_width;
    self.frame = frame;
}

- (void)setQRCode_height:(CGFloat)QRCode_height
{
    CGRect frame = self.frame;
    frame.size.height = QRCode_height;
    self.frame = frame;
}

- (void)setQRCode_x:(CGFloat)QRCode_x
{
    CGRect frame = self.frame;
    frame.origin.x = QRCode_x;
    self.frame = frame;
}

- (void)setQRCode_y:(CGFloat)QRCode_y
{
    CGRect frame = self.frame;
    frame.origin.y = QRCode_y;
    self.frame = frame;
}

- (void)setQRCode_centerX:(CGFloat)QRCode_centerX
{
    CGPoint center = self.center;
    center.x = QRCode_centerX;
    self.center = center;
}

- (void)setQRCode_centerY:(CGFloat)QRCode_centerY
{
    CGPoint center = self.center;
    center.y = QRCode_centerY;
    self.center = center;
}

- (CGFloat)QRCode_centerY
{
    return self.center.y;
}

- (CGFloat)QRCode_centerX
{
    return self.center.x;
}

- (CGFloat)QRCode_width
{
    return self.frame.size.width;
}

- (CGFloat)QRCode_height
{
    return self.frame.size.height;
}

- (CGFloat)QRCode_x
{
    return self.frame.origin.x;
}

- (CGFloat)QRCode_y
{
    return self.frame.origin.y;
}

- (CGFloat)QRCode_top
{
    return self.frame.origin.y;
}

- (void)setQRCode_top:(CGFloat)QRCode_top
{
    CGRect newframe = self.frame;
    newframe.origin.y = QRCode_top;
    self.frame = newframe;
}

- (CGFloat)QRCode_left
{
    return self.frame.origin.x;
}

- (void)setQRCode_left:(CGFloat)QRCode_left
{
    CGRect newframe = self.frame;
    newframe.origin.x = QRCode_left;
    self.frame = newframe;
}

- (CGFloat)QRCode_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setQRCode_bottom:(CGFloat)QRCode_bottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = QRCode_bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)QRCode_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setQRCode_right:(CGFloat)QRCode_right
{
    CGFloat delta = QRCode_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

@end
