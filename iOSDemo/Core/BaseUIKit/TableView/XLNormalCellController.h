//
//  XLNormalCellController.h
//  Demo
//
//  Created by AlexSiu on 2019/4/19.
//  Copyright © 2019 AlexSiu. All rights reserved.
//

#import "XLBaseCellController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLNormalCellController : XLBaseCellController
- (NSString *)featureTitleForCell;
- (UIImage *)featureIconImage;
- (BOOL)featureNeedShowMore;

@end

NS_ASSUME_NONNULL_END
