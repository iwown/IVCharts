//
//  IVSleepBars.h
//  IVCharts
//
//  Created by A$CE on 2019/4/12.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct GGSB_Date {
    int year;
    int month;
    int day;
    int hour;
    int minute;
}GGSB_Date;

@class GGSBSleep;
@interface IVSleepBars : UIView

@property (nonatomic ,strong) UIColor *textColor;

@property (nonatomic ,strong) GGSBSleep *sleepModel;

- (void)reload;

@end


@interface GGSBItem : NSObject

@property (nonatomic ,assign) int st;
@property (nonatomic ,assign) int et;
// 1-start;2-end;3-deep;4-light,placed,6-wake
@property (nonatomic ,assign) int type;

@end


@interface GGSBSleep : NSObject

@property (nonatomic, strong) NSArray <GGSBItem *>*segment;
@property (nonatomic, assign) GGSB_Date start_time;
@property (nonatomic, assign) GGSB_Date end_time;

@end

NS_ASSUME_NONNULL_END
