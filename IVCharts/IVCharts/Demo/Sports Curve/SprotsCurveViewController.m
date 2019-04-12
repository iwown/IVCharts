//
//  SprotsCurveViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/4/12.
//  Copyright © 2019 Iwown. All rights reserved.
//
#import "IVCharts.h"
#import "SprotsCurveViewController.h"

@interface SprotsCurveViewController ()
{
    IVSportsCurve *_curve;
}
@end

@implementation SprotsCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _curve = [[IVSportsCurve alloc] initWithFrame:CGRectMake(0, 100, 375, 375)];
    [self.view addSubview:_curve];
}

- (void)reloadData {
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 20; i ++) {
        int x = 5 * i;
        int y = arc4random()%100 + 50;
        CGPoint point = CGPointMake(x, y);
        [mArr addObject:[NSValue valueWithCGPoint:point]];
    }
    [_curve setDataSource:mArr];
    [_curve reload];
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
