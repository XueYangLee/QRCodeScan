//
//  UIImage+QRCodeExt.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2021/9/13.
//  Copyright © 2021 singularity. All rights reserved.
//

#import "UIImage+QRCodeExt.h"

@implementation UIImage (QRCodeExt)

+ (UIImage *)QRCodeImageNamed:(NSString *)imgName {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"QRCodeResource" ofType:@"bundle"];
    NSString *imagePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imgName]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
