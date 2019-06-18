//
//  IVRateLine.h
//  IVCharts
//
//  Created by A$CE on 2019/6/18.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IVRateLine : UIView

/**! Value is CGPoint*/
@property (nonatomic,strong) NSArray <NSValue *>*dataSource;

/**! Y axis maximum, Default is 200*/
@property (nonatomic, assign)NSInteger bpmMax;
/**! X axis maximum, Default is 144*/
@property (nonatomic, assign)NSInteger xTimeMax;
/**! Default is Gray*/
@property (nonatomic, strong)UIColor   *lineColor;

/**! Default 1*/
@property (nonatomic, assign)NSInteger dot_distance;

/**! Number of horizontal dash line, like scaleplate, color is light gray; default is null*/
@property (nonatomic, assign)NSInteger dashLineNumber;


- (void)reload;

@end

NS_ASSUME_NONNULL_END
