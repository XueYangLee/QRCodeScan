//
//  UIView+Extension.h
//  Moneyhll
//
//  Created by 李雪阳 on 16/7/9.
//  Copyright © 2016年 浙江龙之游旅游开发有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

@end
