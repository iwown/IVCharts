//
//  IVSleepBars.m
//  IVCharts
//
//  Created by A$CE on 2019/4/12.
//  Copyright © 2019 Iwown. All rights reserved.
//
#import "ConstAndStruct.h"
#import "IVSleepBars.h"


@interface IVSleepBars ()
{
    UIView *horizonLine;
    CGFloat _sb_width;
    CGFloat _sb_height;
    CGFloat _gap_margin;
}

@end

@implementation IVSleepBars

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _sb_width = frame.size.width;
        _sb_height = frame.size.height;
        _gap_margin = 28;
        _textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor redColor];
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
    [self drawColumnData];
}

- (void)drawColumnData {
    //画 x 轴
    horizonLine=[UIView new];
    horizonLine.backgroundColor=_textColor;
    horizonLine.frame = CGRectMake(_gap_margin, _sb_height - _gap_margin, _sb_width - (_gap_margin * 2), 1);
    [self addSubview:horizonLine];
    
    //画刻度
    UILabel* startLab=[UILabel new];
    startLab.font=[UIFont systemFontOfSize:12];
    startLab.textColor=_textColor;
    startLab.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)_sleepModel.start_time.hour,(long)_sleepModel.start_time.minute];
    
    [startLab setFrame:CGRectMake(horizonLine.frame.origin.x, _sb_height - _gap_margin + 2, horizonLine.frame.size.width, 12)];
    [startLab sizeToFit];
    [self addSubview:startLab];
    
    UILabel* endLab=[UILabel new];
    endLab.font=[UIFont systemFontOfSize:12];
    endLab.textColor=_textColor;
    endLab.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)_sleepModel.end_time.hour,(long)_sleepModel.end_time.minute];
    [endLab sizeToFit];
    [endLab setFrame:CGRectMake(_sb_width - 40, _sb_height - _gap_margin + 2, horizonLine.frame.size.width, 12)];
    [self addSubview:endLab];
    
    GGSB_Date startDate=_sleepModel.start_time;
    GGSB_Date endDate=_sleepModel.end_time;
    NSInteger durationHour=endDate.hour-startDate.hour;
    if (durationHour<0) {
        durationHour+=24;
    }
    
    NSInteger start = startDate.minute + 60 *startDate.hour;
    NSInteger end = endDate.minute + 60 *endDate.hour;
    NSInteger duation = end - start;
    if (duation < 0) {
        duation = duation + 1440;
    }
    CGFloat length_unit = (float)(_sb_width - 28*2)/duation;
    
    //画第一个刻度
    UIView *first = [UIView new];
    first.backgroundColor = _textColor;
    CGFloat xF = _gap_margin + length_unit * (60-startDate.minute);
    first.frame = CGRectMake(xF, _sb_height - _gap_margin-2, 1, 2);
    [self addSubview:first];
    
    for (int i=1; i<durationHour; ++i) {
        UIView* tmp=[UIView new];
        tmp.backgroundColor=[UIColor whiteColor];
        CGFloat x = (xF + 1) + length_unit * (60*i);
        tmp.frame = CGRectMake(x, _sb_height - _gap_margin-2, 1, 2);
        [self addSubview:tmp];
    }
    
    //画纵轴
//    _sleepModel.segment;
    if (_sleepModel.segment.count < 2) {
        NSLog(@"数据太少，画不出来");
        return;
    }
    
    for (int i = 0; i < _sleepModel.segment.count; i++) {
        GGSBItem *item = _sleepModel.segment[i];
        NSInteger preSleepType = item.type;
        NSInteger startTime = item.st;
        NSInteger endTime = item.et;
        NSInteger activity = endTime - startTime;
        
        CGFloat x = startTime;
        
        UIView* tmp=[UIView new];
        // 1-start;2-end;3-deep;4-light,placed,6-wake
        CGFloat xS = _gap_margin + (x-start) * length_unit;
        CGFloat wS = activity * length_unit;
        CGFloat hS = 130;
        if (preSleepType == 3) {
            hS=130;
            tmp.backgroundColor=[UIColor colorWithRed:0x2b/255.0 green:0x0f/255.0 blue:0x53/255.0 alpha:1];
        }
        else if (preSleepType == 4) {
            hS=80;
            tmp.backgroundColor=[UIColor colorWithRed:0xb4/255.0 green:0x81/255.0 blue:0xff/255.0 alpha:1];
        }
        else if (preSleepType == 6) {
            hS=30;
            tmp.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xba/255.0 blue:0x4a/255.0 alpha:1];
        }
        CGFloat yS = _sb_height - _gap_margin - hS;
        tmp.frame = CGRectMake(xS, yS, wS, hS);
        [self addSubview:tmp];
    }
}


@end



@implementation GGSBItem


@end



@implementation GGSBSleep


@end


