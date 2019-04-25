//
//  XLNavigationController.h
//  Coinbon
//
//  Created by AlexSiu on 2018/6/11.
//  Copyright © 2018年 CoinSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLNavigationController : UINavigationController
+ (XLNavigationController *)navigtionControllerWithRootVC:(UIViewController *)rootVC;

@end


@interface UIViewController (XLNavigationController)
- (BOOL)navigationShouldPopOnBackButton;

@end
