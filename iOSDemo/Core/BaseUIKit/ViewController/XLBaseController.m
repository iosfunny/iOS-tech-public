//
//  XLBaseController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/19.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLBaseController.h"

@interface XLBaseController ()

@end

@implementation XLBaseController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 全部统一纯手动布局，关闭默认偏移
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.view setBackgroundColor:[UIColor xl_defaultBGColor]];
    
}

@end
