//
//  WeightLineViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/8/21.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "WeightLineViewController.h"
#import "IVWeightLine.h"

@interface WeightLineViewController ()
{
    IVWeightLine *_line;
}
@end

@implementation WeightLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _line = [[IVWeightLine alloc] initWithFrame:CGRectMake(0, 100, 375, 260)];
    [_line setLeftLabels:@[@"100",@"80",@"60",@"40",@"20"]];
    [_line setRightLabels:@[@"",@"很重",@"重",@"一般",@"瘦"]];

//    _line.dashLineNumber = 3;
//    _line.bpmMax = 150;
    [self.view addSubview:_line];
}

- (void)reloadData {
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 5; i ++) {
        int x = 1 * i;
        int y = arc4random()%50 + 50;
        CGPoint point = CGPointMake(x, y);
        [mArr addObject:[NSValue valueWithCGPoint:point]];
    }
    [_line setDataSource:mArr];
    [_line reload];
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
