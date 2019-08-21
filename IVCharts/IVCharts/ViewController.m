//
//  ViewController.m
//  IVCharts
//
//  Created by A$CE on 2019/3/28.
//  Copyright © 2019年 Iwown. All rights reserved.
//
#import "ViewController.h"
#import "RriScatterViewController.h"
#import "SprotsCurveViewController.h"
#import "SleepBarViewController.h"
#import "Demo/Rate Line/RateLineViewController.h"
#import "Demo/Time Bar/TimeBarViewController.h"
#import "Demo/Weight Line/WeightLineViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Iwown Charts"];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initData {
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *arr = @[@"Rri Scatter",@"Sports Curve",@"Sleep Bar",
                     @"Time Bar",@"Rate Line",@"Weight Line"];
    [_dataSource addObjectsFromArray:arr];
}

- (void)initUI {
    [self drawTableView];
}

- (void)drawTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataSource[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *rsVC;
    switch (indexPath.row) {
        case 0:
            rsVC = [[RriScatterViewController alloc] init];
            break;
        case 1:
            rsVC = [[SprotsCurveViewController alloc] init];
            break;
        case 2:
            rsVC = [[SleepBarViewController alloc] init];
            break;
        case 3:
            rsVC = [[TimeBarViewController alloc] init];
            break;
        case 4:
            rsVC = [[RateLineViewController alloc] init];
            break;
        case 5:
            rsVC = [[WeightLineViewController alloc] init];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:rsVC animated:YES];
}

@end
