//
//  RriScatterViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/3/28.
//  Copyright © 2019年 Iwown. All rights reserved.
//
#import "IVCharts.h"
#import "RriScatterViewController.h"

@interface RriScatterViewController ()
{
    IVRriScatter *_scatter;
}
@end

@implementation RriScatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _scatter = [[IVRriScatter alloc] initWithFrame:CGRectMake(0, 100, 375, 375)];
    _scatter.baseColor = [UIColor greenColor];
    [self.view addSubview:_scatter];
}

- (void)reloadData {
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 100; i ++) {
        int x = arc4random()%1900+ 20;
        int y = arc4random()%1900 + 50;
        CGPoint point = CGPointMake(x, y);
        [mArr addObject:[NSValue valueWithCGPoint:point]];
    }
    _scatter.dataSource = mArr;
    [_scatter reload];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
