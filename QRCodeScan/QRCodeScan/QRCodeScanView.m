//
//  QRCodeScanView.m
//  QRCodeScan
//
//  Created by 李雪阳 on 2019/12/10.
//  Copyright © 2019 singularity. All rights reserved.
//

#import "QRCodeScanView.h"
#import "QRCodeScanHeader.h"
#import "QRCodeScanTools.h"


@interface QRCodeScanView ()<UITextFieldDelegate>

/**计时器*/
@property (strong, nonatomic) CADisplayLink *link;
/**实际有效扫描区域的背景图(亦或者自己设置一个边框)*/
@property (strong, nonatomic) UIImageView *bgImg;
/**有效扫描区域循环往返的一条线（这里用的是一个背景图）*/
@property (strong, nonatomic) UIImageView *scrollLine;
/**扫码有效区域外自加的文字提示*/
@property (strong, nonatomic) UILabel *tip;
/**用于记录scrollLine的上下循环状态*/
@property (assign, nonatomic) BOOL lineAnimateUp;
/** 遮盖图层 */
@property (nonatomic,weak) CAShapeLayer *shapeLayer;
/** 遮盖视图 */
@property (nonatomic,strong) UIView *maskView;
/** 切换按钮 */
@property (nonatomic,strong) UIButton *switchBtn;
/** 手动输入框 */
@property (nonatomic,strong) UITextField *codeNumText;
@property (nonatomic,strong) UIView *codeTextView;

@end

@implementation QRCodeScanView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        self.lineAnimateUp = YES;
        [self setScanView];
        [self setMaskViewShapeLayer];
    }
    return self;
}


- (void)setScanView{
    
    //添加一个可见的扫描有效区域的框（这里直接是设置一个背景图片）
    [self addSubview:self.bgImg];
    //添加一个上下循环运动的线条（这里直接是添加一个背景图片来运动）
    [self addSubview:self.scrollLine];
    //添加遮罩图层
    [self addSubview:self.maskView];
    //添加其他有效控件
    [self addSubview:self.tip];
    [self addSubview:self.switchBtn];
}


- (void)setMaskViewShapeLayer{
    //设置中空区域，即有效扫描区域(中间扫描区域透明度比周边要低的效果)绘制黑色底框 中空正方形
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self scanPath].CGPath;
    self.maskView.layer.mask = shapeLayer;
    _shapeLayer=shapeLayer;
}



- (void)setShowScanInputExchange:(BOOL)showScanInputExchange{
    _showScanInputExchange=showScanInputExchange;
    self.switchBtn.hidden=!showScanInputExchange;
}


- (void)addLineAnimateLoop{
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLineAnimateLoop{
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


#pragma mark -扫描区域动画类型转换
- (void)setScanTypeTransform:(ScanViewAnimationTransform)transformType
{
    [_shapeLayer addAnimation:[self animationType:transformType] forKey:@"animate"];
    _maskView.layer.mask = _shapeLayer;
}

#pragma mark -动画切换样式
- (CAKeyframeAnimation *)animationType:(ScanViewAnimationTransform)animationType{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    if (animationType==ScanToInput) {//从扫描到输入
        keyframeAnimation.values = @[(__bridge id)[self scanPath].CGPath,
                                     (__bridge id)[self inputPath].CGPath];
    }else{//从输入到扫描
        keyframeAnimation.values = @[(__bridge id)[self inputPath].CGPath,
                                     (__bridge id)[self scanPath].CGPath];
    }
    //    keyframeAnimation.keyTimes = @[@(0.0), @(0.3), @(0.5), @(0.75), @(0.9)];
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.duration = 0.5;
    return keyframeAnimation;
}

- (UIBezierPath *)scanPath{
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_BarBGImgHeight) cornerRadius:1] bezierPathByReversingPath]];
    return rectPath;
}

- (UIBezierPath *)inputPath{
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_InputTextHeight) cornerRadius:1] bezierPathByReversingPath]];
    return rectPath;
}


#pragma mark -输入结果
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.textInputResult) {
        self.textInputResult(textField.text);
    }
    return YES;
}


#pragma mark -切换状态
- (void)exchangeSacnClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    if (!sender.selected) {//扫描
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];//均匀线性动画
            self.bgImg.frame=CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_BarBGImgHeight);
            [self setScanTypeTransform:InputToScan];
            [self.codeTextView removeFromSuperview];
            [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            self.switchBtn.frame=CGRectMake(QRCode_SCREEN_WIDTH/2-59, QRCode_MaxY(self.bgImg)+16, 118, 32);
        } completion:^(BOOL finished) {
            [self.codeNumText resignFirstResponder];
            [self addSubview:self.scrollLine];
            [self addSubview:self.tip];
            if (self.scanViewTransformExchange) {
                self.scanViewTransformExchange(InputToScan);
            }
        }];
        
    }else{//手动输入
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            self.bgImg.frame=CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_InputTextHeight);
            [self setScanTypeTransform:ScanToInput];
            [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            [self.scrollLine removeFromSuperview];
            [self.tip removeFromSuperview];
            self.switchBtn.frame=CGRectMake(QRCode_SCREEN_WIDTH/2-59, QRCode_MaxY(self.bgImg)+16, 118, 32);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self addSubview:self.codeTextView];
            });
        } completion:^(BOOL finished) {
            [self.codeNumText becomeFirstResponder];
            if (self.scanViewTransformExchange) {
                self.scanViewTransformExchange(ScanToInput);
            }
        }];
        
    }
}


#pragma mark - 线条运动的动画
- (void)LineAnimation {
    if (self.lineAnimateUp) {
        CGFloat y = self.scrollLine.frame.origin.y;
        y += 2;
        [self.scrollLine setQRCode_y:y];
        if (y >= (QRCode_BarBGImgY+QRCode_BarBGImgHeight-QRCode_ScrollLineHeight)) {
            self.lineAnimateUp = NO;
        }
    }else{
        CGFloat y = self.scrollLine.frame.origin.y;
        y -= 2;
        [self.scrollLine setQRCode_y:y];
        if (y <= QRCode_BarBGImgY) {
            self.lineAnimateUp = YES;
        }
    }
}

#pragma mark -基础视图
- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_BarBGImgHeight)];
        _bgImg.image = [UIImage QRCodeImageNamed:@"scan_scanFrame"];
    }
    return _bgImg;
}

- (UIImageView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIImageView alloc]initWithFrame:CGRectMake(QRCode_BarBGImgX, QRCode_BarBGImgY, QRCode_BarBGImgWidth, QRCode_ScrollLineHeight)];
        _scrollLine.image = [UIImage QRCodeImageNamed:@"scan_scanLine"];
    }
    return _scrollLine;
}

- (UILabel *)tip {
    if (!_tip) {
        _tip = [[UILabel alloc]initWithFrame:CGRectMake(QRCode_BarBGImgX, QRCode_BarTipY, QRCode_BarBGImgWidth, QRCode_BarTipHeight)];
        _tip.text = @"二维码/条形码扫描";
        _tip.numberOfLines = 0;
        _tip.textColor = [UIColor whiteColor];
        _tip.textAlignment = NSTextAlignmentCenter;
        _tip.font = [UIFont systemFontOfSize:13];
    }
    return _tip;
}

- (UIButton *)switchBtn{
    if (!_switchBtn) {
        _switchBtn=[UIButton new];
        _switchBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_switchBtn setTitle:@" 切换手动输入" forState:UIControlStateNormal];
        [_switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_switchBtn addTarget:self action:@selector(exchangeSacnClick:) forControlEvents:UIControlEventTouchUpInside];
        _switchBtn.frame=CGRectMake(QRCode_SCREEN_WIDTH/2-59, QRCode_MaxY(_bgImg)+16, 118, 32);
        _switchBtn.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.35];
        [_switchBtn setImage:[UIImage QRCodeImageNamed:@"scan_exchange"] forState:UIControlStateNormal];
        [_switchBtn setTitle:@" 切换至扫描" forState:UIControlStateSelected];
        _switchBtn.layer.masksToBounds=YES;
        _switchBtn.layer.cornerRadius=16.5;
        _switchBtn.selected=NO;
        _switchBtn.hidden=YES;
    }
    return _switchBtn;
}

- (UIView *)codeTextView{
    if (!_codeTextView) {
        _codeTextView=[[UIView alloc]initWithFrame:CGRectMake(QRCode_BarBGImgX+1, QRCode_BarBGImgY+1, QRCode_BarBGImgWidth-2, QRCode_InputTextHeight-2)];
        _codeTextView.backgroundColor=[QRCode_BLACK_COLOR colorWithAlphaComponent:0.75];
        
        _codeNumText=[UITextField new];
        _codeNumText.placeholder=@"二维码/条形码";
        _codeNumText.font=[UIFont systemFontOfSize:15];
        _codeNumText.textColor=[UIColor whiteColor];
        _codeNumText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_codeNumText.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _codeNumText.frame=CGRectMake(15, 0, _codeTextView.QRCode_width-15, _codeTextView.QRCode_height);
        _codeNumText.clearButtonMode=UITextFieldViewModeWhileEditing;
        _codeNumText.returnKeyType=UIReturnKeySearch;
        _codeNumText.delegate=self;
        [_codeTextView addSubview:self.codeNumText];
    }
    return _codeTextView;
}


- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(LineAnimation)];
    }
    return _link;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:QRCode_BGAlpha];
    }
    return _maskView;
}



@end
