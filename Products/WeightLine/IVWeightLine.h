//
//  IVWeightLine.h
//  IVCharts
//
//  Created by A$CE on 2019/8/21.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstAndStruct.h"

NS_ASSUME_NONNULL_BEGIN



@protocol IVWeightLineViewDelegate <NSObject>

@optional

- (void)ivWeightLineScrollAtIndex:(NSInteger)index;
- (CGFloat)ivWeightLineTargetGoal;
- (NSString *)ivWeightLineTargetGoalText;
- (NSString *)ivWeightLineCurrentTargetGapText;

@end


@interface IVWeightLine : UIView


@property (nonatomic ,assign)id<IVWeightLineViewDelegate> delegate;

@property (nonatomic ,strong) NSArray <NSNumber *>*dataSource;

/**! 屏显数据个数*/
@property (nonatomic ,assign) NSInteger showNumber;
@property (nonatomic ,assign) BOOL showGoal;

@property (nonatomic ,assign) IVSColor textColor;
@property (nonatomic ,assign) IVSColor textGrayColor;
@property (nonatomic ,assign) IVSColor lineColor;
@property (nonatomic ,assign) IVSColor coinColor;
@property (nonatomic ,assign) IVSColor highLightColor;

@property (nonatomic ,assign) IVSColor goalColor;
@property (nonatomic ,assign) IVSColor bottomLineColor;

@property (nonatomic ,strong) NSArray <NSString *>*leftLabels;
@property (nonatomic ,strong) NSArray <NSString *>*rightLabels;
/*Default is -1, means no high light label, High */
@property (nonatomic ,assign) NSInteger rightHighLightIndex;

- (void)reload;

@end

NS_ASSUME_NONNULL_END
