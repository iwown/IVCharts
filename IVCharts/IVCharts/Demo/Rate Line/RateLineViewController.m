//
//  RateLineViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/6/18.
//  Copyright © 2019 Iwown. All rights reserved.
//
#import "IVRateLine.h"
#import "RateLineViewController.h"

@interface RateLineViewController ()
{
    IVRateLine *_line;
}

@end


@implementation RateLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _line = [[IVRateLine alloc] initWithFrame:CGRectMake(0, 100, 375, 375)];
    _line.dashLineNumber = 3;
    _line.bpmMax = 150;
    [self.view addSubview:_line];
}

- (void)reloadData {
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 144; i ++) {
        int x = 1 * i;
        int y = 0; //arc4random()%100 + 50;
        if (i == 50) {
            y = 98;
        }
        CGPoint point = CGPointMake(x, y);
        [mArr addObject:[NSValue valueWithCGPoint:point]];
    }
    [_line setDataSource:mArr];
    [_line reload];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reloadData];
}

@end
