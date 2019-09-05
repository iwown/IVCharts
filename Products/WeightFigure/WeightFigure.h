//
//  WeightFigure.h
//  IVCharts
//
//  Created by A$CE on 2019/9/5.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    float bmi;  /*0-100*/
    float body_fat; /*0-100*/
}SW_figure;

NS_ASSUME_NONNULL_BEGIN

@interface WeightFigure : UIView

@property (nonatomic ,assign) SW_figure weightFigure;

- (void)reloadData;

@end


typedef enum {
    horizontal = 0,
    vertical
} DashLineDirection;

@interface IVDashLineView : UIView

@property (nonatomic ,assign) DashLineDirection direction;

@end


NS_ASSUME_NONNULL_END
