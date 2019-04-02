//
//  UnilateralChart.h
//  TestChar
//
//  Created by 曹凯 on 2017/7/5.
//  Copyright © 2017年 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SportsCurveDelegate <NSObject>

- (NSString *)showTextOnSpecialPoint:(CGPoint)point;

@end

@interface IVSportsCurve : UIView

@property (nonatomic ,weak) id<SportsCurveDelegate> delegate;

@property (nonatomic ,assign) CGFloat maxX;

/*unit height gap ,default is 1*/
@property (nonatomic ,assign) CGFloat hrScale;
/*default is ascend*/
@property (nonatomic ,assign) BOOL ascend;
/*Type number of  horizontal lines ,default is 5*/
@property (nonatomic ,assign) int lineNumber;

- (void)setDataSource:(NSArray <NSValue *>*)arr;
- (void)addLeftView:(NSArray <NSString *>*)leftTitles;
- (void)addBottomView:(NSArray <NSString *>*)bottomTitles;
@end

@interface IVSCDashMarkLine : UIView

@property (nonatomic ,strong) UILabel *titleLabel;

@end
