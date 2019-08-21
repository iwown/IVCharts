//
//  IVTimeBar.h
//  IVCharts
//
//  Created by A$CE on 2019/6/4.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstAndStruct.h"

NS_ASSUME_NONNULL_BEGIN

@interface IVTimeBar : UIView

/**
 *  横坐标
 */
@property (nonatomic,strong) NSArray <NSString *> *xLabels;

/**
 *  柱子数组
 */
@property (nonatomic,strong) NSArray <NSNumber *> *dataSource;

/**
 *  最大值，即最上面的点的值，
 *  默认是0，表示未设置最大值范围，TimeBar会在setDataSource时根据数据的大小获取最大值范围。
 */
@property (nonatomic, assign) NSInteger maxValue;

/**
 * (horizontal)水平的背景虚线的数量，默认是0.
 * 只有当numOfLevel>0时，levelColor和dashLevel才有意义。
 * levelColor默认0XEEEEEEFF
 * dashLevel默认NO
 */
@property (nonatomic, assign) NSInteger numOfLevel;
@property (nonatomic, assign) IVSColor levelColor;
@property (nonatomic, assign) BOOL dashLevel;

/**
 * 柱子颜色，默认White
 */
@property (nonatomic, strong) UIColor *barColor;

/**
 * 当需要设置渐变色的柱子时使用，默认nil
 */
@property (nonatomic, strong) UIColor *barGlColor;

/**
 * 镜像柱子颜色，默认0XDFDFDF33
 */
@property (nonatomic, strong) UIColor *barMirrorColor;

/**
 * 底部文本颜色，默认White
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 * 底部文本颜色，默认White
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * 是否显示底部坐标线，默认YES;
 */
@property (nonatomic ,assign) BOOL showBottomLine;

/**
 * 是否显示镜像柱子，默认NO;
 */
@property (nonatomic ,assign) BOOL showVisonalBar;

/**
 * 是否在柱子顶端显示值，默认NO;
 * 注意，仅当showVisonalBar=NO时有效。
 */
@property (nonatomic ,assign) BOOL showBarValue;

/*刷新UI*/
- (void)reload;

@end

NS_ASSUME_NONNULL_END
