//
//  CycleDownLoadView.h
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/11/4.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^StartAction)(void);

@interface CycleDownLoadView : UIView

@property (nonatomic,copy) StartAction startBlock;
- (void)startAnimation;
- (void)stopAnimation;

@property (nonatomic,assign) CGFloat progress;

- (void)resetView;
@end

NS_ASSUME_NONNULL_END
