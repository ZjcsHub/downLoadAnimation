//
//  UIView+Extention.m
//  动态画环形进度
//
//  Created by App005 SYNERGY on 2019/11/15.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

#import "UIView+Extention.h"

#import <AppKit/AppKit.h>


@implementation UIView (Extention)
- (void)setShape:(CGPathRef)shape
{
    if (shape == nil)
    {
        self.layer.mask = nil;
    }

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = shape;
    self.layer.mask = maskLayer;
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)xAndWidth
{
    return self.frame.size.width+self.frame.origin.x;
}

-(void)setXAndWidth:(CGFloat)xAndWidth{
    CGFloat delta = xAndWidth - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGFloat)yAndHeight
{
    return self.frame.size.height+self.frame.origin.y;
}

- (void)setYAndHeight:(CGFloat)yAndHeight{
    CGRect newframe = self.frame;
    newframe.origin.y = yAndHeight - self.frame.size.height;
    self.frame = newframe;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
//折线图标题

+(UIView *)setLineTitleView:(NSString*)goal units:(NSString*)units color:(UIColor*)color
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, -20, 250, 30)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView * goalImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 25, 25)];
    goalImage.image = [UIImage imageNamed:@"daily_goal.png"];
    [view addSubview:goalImage];
    
    UILabel * label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor blackColor];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = NSLocalizedString(@"data_details_deily_goal", nil);
    [label1 setFrame:CGRectMake(30, 7, [label1.text sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]}].width, 20)];
    [view addSubview:label1];
    
    UILabel * goalLabel = [[UILabel alloc] init];
    goalLabel.text = goal;
    goalLabel.backgroundColor = [UIColor clearColor];
    [goalLabel setFrame:CGRectMake(label1.xAndWidth, 0, [goalLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}].width, 30)];
    goalLabel.font = [UIFont systemFontOfSize:18];
    goalLabel.textColor = color;
    [view addSubview:goalLabel];
    
    UILabel * unitsLabel = [[UILabel alloc] initWithFrame:CGRectMake(goalLabel.xAndWidth, 7, 60, 20)];
    unitsLabel.text = units;
    unitsLabel.backgroundColor = [UIColor clearColor];
    unitsLabel.textColor = [UIColor blackColor];
    unitsLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:unitsLabel];
    
    return view;
}

@end
