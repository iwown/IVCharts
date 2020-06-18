//
//  IVSleepLineArea.h
//  IVCharts
//
//  Created by A$CE on 2019/12/24.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GGSBSleep;
@interface IVSleepLineArea : UIView

@property (nonatomic ,strong) UIColor *textColor;

@property (nonatomic ,strong) GGSBSleep *sleepModel;

- (void)reload;

@end

NS_ASSUME_NONNULL_END
