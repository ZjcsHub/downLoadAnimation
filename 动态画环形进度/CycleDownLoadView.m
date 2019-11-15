//
//  CycleDownLoadView.m
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/11/4.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import "CycleDownLoadView.h"
#import "UIView+Extention.h"
@interface CycleDownLoadView()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer; // 环形进度
@property (nonatomic , strong) UIView * animationView;
@property (nonatomic , strong) UIColor * drawColor;

@property (nonatomic , strong) CAShapeLayer * downlayer;
@property (nonatomic, strong) CAShapeLayer * drawLineLayer;

@property (nonatomic,assign) CGFloat waveSpeed;
@property (nonatomic,assign) CGFloat offset;
@property (nonatomic,assign) CGFloat waveHeight; // 波形高
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,strong) UILabel * pregressLabel;
@end

@implementation CycleDownLoadView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _drawColor = [UIColor colorWithRed:0.26 green:0.34 blue:0.50 alpha:1.00];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setAnimationAction)];
        [self addGestureRecognizer:tap];
        [self setupData];
        [self setUpUI];
    }
    return self;
}

- (void)setupData{
    _waveSpeed = 1;
    _offset = 0;
    _waveHeight = 40;
}
- (void)setUpUI{
    // 先画一个进度的背景圆环
    CGFloat _lineWidth = 10;
    CGFloat startA = -M_PI_2;
    CGFloat endA =    M_PI_2 + M_PI;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - _lineWidth)/2 startAngle:startA endAngle:endA clockwise:YES];
       
    
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = self.bounds;
    bgLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明色
    bgLayer.lineWidth = _lineWidth;
    bgLayer.strokeColor = [UIColor colorWithRed:212.0/255.0 green:212.0/225.0 blue:212.0/225.0 alpha:1].CGColor;  //ZCCRGBColor(, 212, 212, 1.0).CGColor;//线条颜色
    bgLayer.strokeStart = 0;
    bgLayer.strokeEnd = 1;
    bgLayer.path = circlePath.CGPath;
    [self.layer addSublayer:bgLayer];
    
     //圆形进度
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = _lineWidth;
    _shapeLayer.strokeColor = _drawColor.CGColor;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    _shapeLayer.path = circlePath.CGPath;
    _shapeLayer.lineCap = kCALineCapRound;

    [self.layer addSublayer:_shapeLayer];
    
    // 画个箭头
    CGFloat animationViewWidth = self.width - (_lineWidth + 10)*2;
    _animationView = [[UIView alloc] initWithFrame:CGRectMake(_lineWidth + 10, _lineWidth+10, animationViewWidth , animationViewWidth)];
    _animationView.backgroundColor = [UIColor clearColor];
    _animationView.layer.cornerRadius = animationViewWidth / 2;
    _animationView.layer.masksToBounds = YES;
    [self addSubview:_animationView];
    UIBezierPath * linePath = [UIBezierPath bezierPath];
    // 向下的
    CGFloat lineHeight = animationViewWidth*3/4;

    CGPoint startPoint = CGPointMake((animationViewWidth)/2, (animationViewWidth - lineHeight)/2);
    CGPoint endPoint = CGPointMake((animationViewWidth)/2, startPoint.y + lineHeight);
    linePath.lineWidth = _lineWidth;
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endPoint];
    
    linePath.lineCapStyle = kCGLineCapRound;
    
    
    UIBezierPath * cornerPath = [UIBezierPath bezierPath];
    cornerPath.lineWidth = _lineWidth;
    [cornerPath moveToPoint:CGPointMake(startPoint.x - lineHeight/3, startPoint.y + lineHeight/3*2)];
    [cornerPath addLineToPoint:endPoint];
    [cornerPath addLineToPoint:CGPointMake(startPoint.x + lineHeight/3, startPoint.y + lineHeight/3*2)];
    
    [linePath appendPath:cornerPath];
    
    
    
    CAShapeLayer * downlayer = [CAShapeLayer layer];
    downlayer.strokeColor = _drawColor.CGColor;
    downlayer.fillColor = [UIColor clearColor].CGColor;
    downlayer.lineWidth = _lineWidth;
    downlayer.strokeStart = 0;
    downlayer.lineCap = kCALineCapRound;
    downlayer.path = linePath.CGPath;
    _downlayer = downlayer;
    [_animationView.layer addSublayer:downlayer];
    
    
    [self drawAnimationLine];
    
    _pregressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2 + _waveHeight / 2, self.width, 30)];
    _pregressLabel.font = [UIFont systemFontOfSize:17];
    _pregressLabel.textColor = [UIColor blackColor];
    _pregressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pregressLabel];
    
}

- (void)drawAnimationLine{
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    _drawLineLayer = lineLayer;
    UIBezierPath * linePath = [UIBezierPath bezierPath];

    [linePath moveToPoint:CGPointMake(30, _animationView.height/2)];
    [linePath addLineToPoint:CGPointMake(_animationView.width - 30, _animationView.height/2)];
    lineLayer.strokeColor = _drawColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 10;
    lineLayer.strokeStart = 1;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.path = linePath.CGPath;
    [_animationView.layer addSublayer:lineLayer];
    
}

- (void)startAnimation{
    _downlayer.strokeEnd = 0;
    _drawLineLayer.strokeStart = 0;
       
   
    _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(changeWase) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)setAnimationAction{
    if (_timer) {
        return;
    }
    if (_startBlock) {
        _startBlock();
    }
    
   
}
- (void)changeWase{
    
    CGFloat maxWidth = _animationView.size.width - 60;
    CGFloat amplitudeLevel = 1;
    CGFloat maxAmplitude = _waveHeight;
    CGFloat maxHeight = _animationView.size.height;
    _offset -= 0.25;
    UIGraphicsBeginImageContext(_animationView.size);
    for(int i=0; i < 5; i++) {
        UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
        CGFloat progress = 1.0f - (CGFloat)i / 5;
        CGFloat nowAmplitudeLevel = (1.5f * progress - 0.5f) * amplitudeLevel;
        for(CGFloat x = 0; x < maxWidth; x ++) {
            CGFloat midScale = 1 - pow(x / (maxWidth / 2)  - 1, 2);
            CGFloat y = midScale * maxAmplitude * nowAmplitudeLevel * sinf(10 * M_PI *(x / maxWidth) * 1 + _offset) + (maxHeight * 0.5);
            if (x==0) {
                [wavelinePath moveToPoint:CGPointMake(x+30, y)];
            }
            else {
                [wavelinePath addLineToPoint:CGPointMake(x+30, y)];
            }
        }
        _drawLineLayer.lineWidth = 5;
        _drawLineLayer.path = [wavelinePath CGPath];
    }
    UIGraphicsEndImageContext();
    
}


- (void)stopAnimation{
    
    if (_timer) {
        [_timer invalidate];
    }
    _pregressLabel.text = @"";
    // 结束展示对勾
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    CGFloat radio = (_animationView.width/5 * 3); // 半径
    CGFloat x = (_animationView.width - radio)/2;
    [path moveToPoint:CGPointMake(x, x + radio/3 *2)];
    [path addLineToPoint:CGPointMake(x + radio/3 , x+radio)];
    [path addLineToPoint:CGPointMake(x+radio, radio/3)];
    
    _drawLineLayer.lineWidth = 10;
    _drawLineLayer.path = [path CGPath];
    
    
}

- (void)resetView{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setUpUI];

}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    _pregressLabel.text = [NSString stringWithFormat:@"%ld%%",(long)(progress*100)];
    _shapeLayer.strokeEnd = progress;
}
@end
