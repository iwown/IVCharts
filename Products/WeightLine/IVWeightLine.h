//
//  IVWeightLine.h
//  IVCharts
//
//  Created by A$CE on 2019/8/21.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Const&&Struct/ConstAndStruct.h"

NS_ASSUME_NONNULL_BEGIN



@protocol IVWeightLineViewDelegate <NSObject>

@optional
- (id)grayLabelDidAnimationAtIndex:(NSInteger)index;

- (void)scrollViewAnimationIsEndingAtIndex:(NSInteger)index;

- (CGFloat)ivWeightLineTargetGoal;
- (NSString *)ivWeightLineTargetGoalText;

@end


@interface IVWeightLine : UIView


@property (nonatomic, strong)NSArray   *dataArr;
@property (nonatomic, assign)NSInteger rawDataCount;
@property (nonatomic ,assign)id<IVWeightLineViewDelegate> delegate;


@property (nonatomic ,strong) NSArray <NSValue *>*dataSource;

/**! 屏显数据个数*/
@property (nonatomic ,assign) NSInteger showNumber;

@property (nonatomic ,assign) IVSColor textColor;

@property (nonatomic ,strong) NSArray <NSString *>*leftLabels;
@property (nonatomic ,strong) NSArray <NSString *>*rightLabels;

- (void)reload;

@end

NS_ASSUME_NONNULL_END
