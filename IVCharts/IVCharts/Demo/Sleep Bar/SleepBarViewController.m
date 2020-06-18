//
//  SleepBarViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/4/12.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "SleepBarViewController.h"
#import "IVSleepBars.h"
#import "IVSleepLineArea.h"
#import "GGSBSleep.h"

@interface SleepBarViewController () {
    IVSleepBars *_bars;
    IVSleepLineArea *_lineArea;
}
@end

@implementation SleepBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _bars = [[IVSleepBars alloc] initWithFrame:CGRectMake(0, 100, 375, 200)];
    [self.view addSubview:_bars];
    
    _lineArea = [[IVSleepLineArea alloc] initWithFrame:CGRectMake(0, 350, 375, 200)];
    [_lineArea setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_lineArea];
}

- (void)reloadData {
    int st = 0;
    int et = arc4random()%60;
    int type = 0;
    int startMinute = et;
    NSMutableArray *itemArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 19; i ++) {
        int gap = arc4random()%30 + i;
        st = et;
        et = st + gap;
        if (i == 0) {
            type = 1;
            et = st;
        }else if (i == 12) {
            type = 2;
            et = st;
        }else if (i == 4) {
            type = 6;
        }else if (i % 3 == 0) {
            type = 3;
        }else if (i % 3 == 1) {
            type = 4;
        }else {
            type = 7;
        }
        GGSBItem *item = [[GGSBItem alloc] init];
        item.st = st;
        item.et = et;
        item.type = type;
        itemArr[i] = item;
    }
    int endH = et/60;
    int endM = et%60;
    
    GGSB_Date sDate = {2019,4,11,0,startMinute};
    GGSB_Date eDate = {2019,4,11,endH,endM};

    GGSBSleep *sleepModel = [[GGSBSleep alloc] init];
    sleepModel.segment = itemArr;
    sleepModel.start_time = sDate;
    sleepModel.end_time = eDate;
    [_bars setSleepModel:sleepModel];
    [_bars reload];
    
    [_lineArea setSleepModel:sleepModel];
    [_lineArea reload];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reloadData];
}

@end
