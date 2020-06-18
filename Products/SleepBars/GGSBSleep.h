//
//  GGSBSleep.h
//  IVCharts
//
//  Created by A$CE on 2019/12/24.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct GGSB_Date {
    int year;
    int month;
    int day;
    int hour;
    int minute;
}GGSB_Date;


@interface GGSBItem : NSObject

@property (nonatomic ,assign) int st;
@property (nonatomic ,assign) int et;
// 1-start;2-end;3-deep;4-light,placed,6-wake,7-EYM
@property (nonatomic ,assign) int type;

@end


@interface GGSBSleep : NSObject

@property (nonatomic, strong) NSArray <GGSBItem *>*segment;
@property (nonatomic, assign) GGSB_Date start_time;
@property (nonatomic, assign) GGSB_Date end_time;

@end

NS_ASSUME_NONNULL_END
