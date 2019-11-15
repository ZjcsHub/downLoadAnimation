//
//  UIView+Extention.h
//  动态画环形进度
//
//  Created by App005 SYNERGY on 2019/11/15.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extention)
- (void)setShape:(CGPathRef)shape;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat xAndWidth;
@property (nonatomic, assign) CGFloat yAndHeight;
//折线图标题
+(UIView *)setLineTitleView:(NSString*)goal units:(NSString*)units color:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
