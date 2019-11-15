//
//  ViewController.m
//  动态画环形进度
//
//  Created by App005 SYNERGY on 2019/11/15.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

#import "ViewController.h"
#import "CycleDownLoadView.h"

@interface ViewController ()
@property (nonatomic,strong) CycleDownLoadView * downLoadView;

@end

@implementation ViewController
- (CycleDownLoadView *)downLoadView{
    if (!_downLoadView) {
        _downLoadView = [[CycleDownLoadView alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 100, self.view.bounds.size.width - 100)];
    }
    return _downLoadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.downLoadView];
      
    

}


@end
