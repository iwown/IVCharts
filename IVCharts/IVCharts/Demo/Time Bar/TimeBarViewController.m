//
//  TimeBarViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/6/5.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "TimeBarViewController.h"
#import "IVTimeBar.h"

@interface TimeBarViewController ()
{
    IVTimeBar *_barA;
    IVTimeBar *_barB;
}

@end

@implementation TimeBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self reloadData];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor greenColor];
    _barA = [[IVTimeBar alloc] initWithFrame:CGRectMake(20, 80, 335, 200)];
    _barA.barColor = [UIColor colorWithRed:0xFF/255.0 green:0x3D/255.0 blue:0x3D/255.0 alpha:1];
    _barA.barGlColor = [UIColor colorWithRed:0xFF/255.0 green:0xA0/255.0 blue:0xC0/255.0 alpha:1];
    _barA.textColor = [UIColor colorWithRed:0x68/255.0 green:0x68/255.0 blue:0x71/255.0 alpha:1];
    _barA.showVisonalBar = YES;
    [self.view addSubview:_barA];
    
    _barB = [[IVTimeBar alloc] initWithFrame:CGRectMake(20, 320, 335, 200)];
    _barB.showBarValue = YES;
    _barB.numOfLevel = 3;
    [self.view addSubview:_barB];
}

- (void)reloadData {
    _barA.dataSource = [self randomSourceArr];
    [_barA reload];
    
    _barB.dataSource = [self randomSourceArr];
    [_barB reload];
}

- (NSArray *)randomSourceArr {
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 24; i ++) {
        int x = arc4random()%200+ 20;
        [mArr addObject:@(x)];
    }
    return mArr;
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
