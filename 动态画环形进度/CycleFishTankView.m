//
//  CycleFishTankView.m
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/11/1.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import "CycleFishTankView.h"
#import "UIView+Extention.h"
@interface CycleFishTankView(){
    float _horizontal;
      float _horizontal2;
    float waterHeight;
}
@property (nonatomic, strong) UIView * dianliangView;
@property (nonatomic, strong) UIView * dianliangView2;

@property(nonatomic,strong)CAShapeLayer *ovalShapeLayer;
@property (nonatomic, strong) NSTimer *waterTimer;
@property (nonatomic, strong) NSTimer *waterTimer2;
@property (nonatomic, strong) UILabel *dianliangLbel;
@property (nonatomic, assign) CGFloat WaterMaxHeight;

@end


@implementation CycleFishTankView




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _WaterMaxHeight = self.bounds.size.width - 40;
        waterHeight = _WaterMaxHeight;//越小越高
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    CGFloat width = self.bounds.size.width;
    
    CGFloat r  = width/2-5;
    CGFloat girth = (M_PI_2 * r)/40;

//
    // 第一层底部虚线圆
    CAShapeLayer *ovalLayer = [CAShapeLayer layer];
    ovalLayer.strokeColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1].CGColor;
    ovalLayer.fillColor = [UIColor clearColor].CGColor;
    ovalLayer.lineWidth = 10;
    ovalLayer.lineDashPattern  = @[@(girth/5*2),@(girth/5*3)];
    ovalLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5,5,2 * (width)/2-10,2 * (width)/2-10)].CGPath;
    [self.layer addSublayer:ovalLayer];
    
    // 第二层黄色的虚线圆 电量多少的
       self.ovalShapeLayer = [CAShapeLayer layer];
    self.ovalShapeLayer.strokeColor = [UIColor colorWithRed:0.26 green:0.34 blue:0.50 alpha:1.00].CGColor;
       self.ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
       self.ovalShapeLayer.lineWidth = 10;
       self.ovalShapeLayer.lineDashPattern  = @[@(girth/5*2),@(girth/5*3)];
       CGFloat refreshRadius = (width)/2;
        CGFloat startA = -M_PI_2;
       CGFloat endA =    M_PI_2 + M_PI;
       self.ovalShapeLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, width / 2) radius: (width)/2-5 startAngle:startA endAngle:endA clockwise:YES].CGPath;//[UIBezierPath bezierPathWithOvalInRect:CGRectMake(5,5,2 * refreshRadius-10,2 * refreshRadius-10)].CGPath;
        self.ovalShapeLayer.strokeStart = 0;
       self.ovalShapeLayer.strokeEnd = 0;
       [self.layer addSublayer:self.ovalShapeLayer];
    
    // 白色实线的小圆圈
    CAShapeLayer *ocircleLayer = [CAShapeLayer layer];
   ocircleLayer.strokeColor = [UIColor colorWithRed:0.64 green:0.71 blue:0.87 alpha:1.00].CGColor;
   ocircleLayer.fillColor = [UIColor clearColor].CGColor;
   ocircleLayer.lineWidth = 1;
   ocircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(15,15,2 * refreshRadius-30,2 * refreshRadius-30)].CGPath;
    [self.layer addSublayer:ocircleLayer];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, width-40)];
    [self addSubview:backView];
    backView.layer.cornerRadius = (width-40)/2;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor colorWithRed:0.26 green:0.34 blue:0.50 alpha:1.00];
    
    
    /// 第一层水波纹view ===========================
    self.dianliangView = [[UIView alloc] initWithFrame:CGRectMake(20,  20, width-40, width-40)];
    [self addSubview:self.dianliangView];
    self.dianliangView.layer.cornerRadius = (width-40)/2;
    self.dianliangView.layer.masksToBounds = YES;
    self.dianliangView.backgroundColor = [UIColor colorWithRed:0.34 green:0.40 blue:0.71 alpha:0.80];
    /// 第二层水波纹 view =======================
    self.dianliangView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, width-40, width-40)];
    [self addSubview:self.dianliangView2];
    self.dianliangView2.layer.cornerRadius = (width-40)/2;
    self.dianliangView2.layer.masksToBounds = YES;
    self.dianliangView2.backgroundColor = [UIColor colorWithRed:0.32 green:0.52 blue:0.82 alpha:0.60];
    
    self.dianliangLbel = [[UILabel alloc] initWithFrame:CGRectMake( 20,  20 + (width-40)/2-30, width-40, 60)];
       [self addSubview:self.dianliangLbel];
       self.dianliangLbel.font = [UIFont systemFontOfSize:50];
       self.dianliangLbel.textAlignment = NSTextAlignmentCenter;
       self.dianliangLbel.textColor = [UIColor whiteColor];
       
       self.waterTimer = [NSTimer scheduledTimerWithTimeInterval:0.08 target:self selector:@selector(waterAction) userInfo:nil repeats:YES];
       self.waterTimer2 = [NSTimer scheduledTimerWithTimeInterval:0.10 target:self selector:@selector(waterAction2) userInfo:nil repeats:YES];
}
- (void)waterAction{
    CGMutablePathRef wavePath = CGPathCreateMutable();
    CGPathMoveToPoint(wavePath, nil, 0,-_WaterMaxHeight*0.5);
    float y = 0;
    _horizontal += 0.15;
    for (float x = 0; x <= self.dianliangView.frame.size.width; x++) {
        //峰高* sin(x * M_PI / self.frame.size.width * 峰的数量 + 移动速度)
        y = 7* sin(x * M_PI / self.dianliangView.frame.size.width * 2 - _horizontal) ;
        CGPathAddLineToPoint(wavePath, nil, x, y+waterHeight);
    }
    CGPathAddLineToPoint(wavePath, nil, self.dianliangView.frame.size.width , _WaterMaxHeight*0.5);
    CGPathAddLineToPoint(wavePath, nil, self.dianliangView.frame.size.width, _WaterMaxHeight);
    CGPathAddLineToPoint(wavePath, nil, 0, _WaterMaxHeight);
    [self.dianliangView setShape:wavePath];
}

- (void)waterAction2{
    CGMutablePathRef wavePath2 = CGPathCreateMutable();
    CGPathMoveToPoint(wavePath2, nil, 0,-_WaterMaxHeight*0.5);
    float y2 = 0;
    _horizontal2 += 0.1;
    for (float x2 = 0; x2 <= self.dianliangView2.frame.size.width; x2++) {
        //峰高* sin(x * M_PI / self.frame.size.width * 峰的数量 + 移动速度)
        y2 = -5* cos(x2 * M_PI / self.dianliangView2.frame.size.width * 2 + _horizontal2) ;
        CGPathAddLineToPoint(wavePath2, nil, x2, y2+waterHeight);
    }
    CGPathAddLineToPoint(wavePath2, nil, self.dianliangView2.frame.size.width , _WaterMaxHeight*0.5);
    CGPathAddLineToPoint(wavePath2, nil, self.dianliangView2.frame.size.width, _WaterMaxHeight);
    CGPathAddLineToPoint(wavePath2, nil, 0, _WaterMaxHeight);
    [self.dianliangView2 setShape:wavePath2];
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    if (progress >= 0 || progress <= 1){
        waterHeight = (1-progress)*_WaterMaxHeight;
        self.dianliangLbel.text = [NSString stringWithFormat:@"%.0f%@",progress*100,@"%"];
        self.ovalShapeLayer.strokeEnd = progress;
    }
}
- (void)dealloc{
    
    [_waterTimer invalidate];
    [_waterTimer2 invalidate];
    _waterTimer = nil;
    _waterTimer2 = nil;
}
@end
