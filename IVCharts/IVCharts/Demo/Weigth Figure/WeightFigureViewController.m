//
//  WeightFigureViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/9/5.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "WeightFigureViewController.h"
#import "IVWeightFigure.h"

@interface WeightFigureViewController ()
{
    IVWeightFigure *_figure;
}
@end

@implementation WeightFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _figure = [[IVWeightFigure alloc] initWithFrame:CGRectMake(0, 100, 320, 295)];
    [self.view addSubview:_figure];
}

- (void)reloadData {
    SW_figure fig = {22.43,26};
    [_figure setWeightFigure:fig];
    [_figure reloadData];
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
