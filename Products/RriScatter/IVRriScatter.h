//
//  IVRriScatter.h
//  IVCharts
//
//  Created by A$CE on 2019/3/28.
//  Copyright © 2019年 Iwown. All rights reserved.
//

#import "ConstAndStruct.h"

NS_ASSUME_NONNULL_BEGIN

@interface IVRriScatter : UIView

@property (nonatomic ,assign) IVSColor pointColor;

@property (nonatomic ,strong) UIColor *baseColor;

@property (nonatomic ,strong) NSArray <NSValue *>*dataSource;

/*Call this method if you want to refresh the graph*/
- (void)reload;

@end

NS_ASSUME_NONNULL_END
