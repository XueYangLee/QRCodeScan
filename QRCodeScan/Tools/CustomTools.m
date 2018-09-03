//
//  CustomTools.m
//  moneyhll
//
//  Created by 李雪阳 on 16/11/7.
//  Copyright © 2016年 浙江龙之游旅游开发有限公司. All rights reserved.
//


#import "CustomTools.h"

@interface CustomTools ()

@end

@implementation CustomTools

#pragma mark 自定义Label
+ (UILabel *)labelWithTitle:(NSString *)text Font:(NSInteger)font textColor:(UIColor *)color
{
    UILabel *label=[UILabel new];
    label.text=text;
    label.font=[UIFont systemFontOfSize:font];
    label.textColor=color;
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}

#pragma mark 自定义button
+ (UIButton *)buttonWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIViewController *)vc
{
    UIButton *btn=[UIButton new];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:vc action:btnSelect forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark 自定义View层上button
+ (UIButton *)buttonFromViewWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIView *)vc
{
    UIButton *btn=[UIButton new];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:vc action:btnSelect forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:btn];
    return btn;
}


#pragma mark 自定义textfield
+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder textFont:(NSInteger)font textColor:(UIColor *)color
{
    UITextField *text=[UITextField new];
    text.placeholder=placeHolder;
    text.font=[UIFont systemFontOfSize:font];
    text.textColor=color;
    return text;
}



@end
