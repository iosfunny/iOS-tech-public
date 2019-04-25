//
//  TestViewController.m
//  Demo
//
//  Created by AlexSiu on 2019/4/18.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+XLLayout.h"

@interface TestViewController ()
@property (nonatomic, strong) UIButton * button;
@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Button" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (void)buttonDidClick
{
    NSLog(@"Click");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.button.frame = CGRectMake(40, 200, self.view.width - 80, 44);
}

@end




//+ (void)observerTest
//{
//    /**
//     param1: 给observer分配存储空间
//     param2: 需要监听的状态类型:kCFRunLoopAllActivities监听所有状态
//     param3: 是否每次都需要监听，如果NO则一次之后就被销毁，不再监听，类似定时器的是否重复
//     param4: 监听的优先级，一般传0
//     param5: 监听到的状态改变之后的回调
//     return: 观察对象
//     */
//    CFRunLoopObserverRef  observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        switch (activity) {
//            case kCFRunLoopEntry:
//                //                NSLog(@"即将进入runloop");
//                break;
//            case kCFRunLoopBeforeTimers:
//                //                NSLog(@"即将处理timer");
//                break;
//            case kCFRunLoopBeforeSources:
//                //                NSLog(@"即将处理input Sources");
//                break;
//            case kCFRunLoopBeforeWaiting:
//                //                NSLog(@"即将睡眠");
//                break;
//            case kCFRunLoopAfterWaiting:
//                //                NSLog(@"从睡眠中唤醒，处理完唤醒源之前");
//                break;
//            case kCFRunLoopExit:
//                //                NSLog(@"退出");
//                break;
//            default:
//                break;
//        }
//    });
//
//    CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], observer, kCFRunLoopDefaultMode);
//}
//
//+ (void)doFireTimer {
//    NSLog(@"---fire---");
//}
