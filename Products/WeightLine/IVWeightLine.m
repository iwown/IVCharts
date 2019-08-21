//
//  IVWeightLine.m
//  IVCharts
//
//  Created by A$CE on 2019/8/21.
//  Copyright © 2019 Iwown. All rights reserved.
//
#import "IVCoinLine.h"
#import "IVWeightLine.h"

#define REMOVE_TAG 1234567890


@interface IVWeightLine ()<UIScrollViewDelegate> {
    CGFloat _gapW;
    
    UILabel *_weightLabel;
    UILabel *_grayLab;
    
    UIScrollView *_scroll;
    IVCoinLine *_coin;
    
    UIColor *__uiTextColor;
}

@end


@implementation IVWeightLine

- (void)reload {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        [self initParam];
        [self initUI];
    }
    return self;
}

- (void)initParam {
    __uiTextColor = [UIColor whiteColor];
    _gapW = (self.frame.size.width / 9);
}

- (void)initUI {
    _weightLabel = [[UILabel alloc]init];
    _grayLab = [[UILabel alloc] init];
}

- (void)setTextColor:(IVSColor)textColor {
    __uiTextColor = [UIColor colorWithRed:textColor.red green:textColor.green blue:textColor.blue alpha:textColor.alpha];
}

- (void)drawUI {
    self.userInteractionEnabled = YES;
    
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, self.frame.size.width - 100, 35)];
    weightLabel.textColor = [UIColor whiteColor];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.font = [UIFont systemFontOfSize:24];
    [self addSubview:weightLabel];
    _weightLabel = weightLabel;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 150)];
    [scroll setContentOffset:CGPointMake((_dataArr.count-1) *_gapW, scroll.bounds.origin.y)];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = self;
    CGFloat width = scroll.frame.size.width;
    CGFloat height = scroll.frame.size.height;
    
    [scroll setContentSize:CGSizeMake(_gapW * (_dataArr.count - 1) + width, height)];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - _gapW) / 2, 60, _gapW, height)];
    [img setBackgroundColor:[UIColor clearColor]];
    [img setTag:REMOVE_TAG];
    [self addSubview:img];
    
    [_grayLab setFrame:CGRectMake((_gapW-10) * 0.5, 0, 10, 10)];
    [_grayLab.layer setCornerRadius:5];
    [_grayLab setBackgroundColor:[UIColor whiteColor]];
    _grayLab.layer.masksToBounds = YES;
    _grayLab.layer.borderColor = [UIColor grayColor].CGColor;
    _grayLab.layer.borderWidth = 3;
    [img addSubview:_grayLab];
    
    IVCoinLine *coin = [[IVCoinLine alloc] initWithFrame:CGRectMake(width / 2, 0, _gapW * (_dataArr.count - 1), height) gapW:_gapW];
    [coin setArr:_dataArr];
    [scroll addSubview:coin];
    [self addSubview:scroll];
    _coin = coin;
    
    CGFloat _target = [_delegate ivWeightLineTargetGoal];
    CGFloat targetY = 0;
    CGFloat maxY = [_coin yMax];
    CGFloat minY = [_coin yMin];
    targetY = scroll.frame.origin.y + (height - 20) * (1- (_target - minY)/(maxY - minY)) + 10;
    
    UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, targetY - 30, 100, 30)];
    targetLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Goal", @"目标体重"), [_delegate ivWeightLineTargetGoalText]];
    targetLabel.textColor = [UIColor whiteColor];
    targetLabel.font = [UIFont systemFontOfSize:13];
    targetLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:targetLabel];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(0, targetY, width, 1)];
    [self drawDashLine:vLine lineLength:6 lineSpacing:4 lineColor:[UIColor whiteColor] direction:0];
    [self addSubview:vLine];
    
    if (_target == 0) {
        targetLabel.hidden = YES;
        vLine.hidden = YES;
    }
    
    [self showGrayLabelAniamtion:scroll.bounds.size.height index:_dataArr.count -1];
    [self endAnimation:scroll];
}

- (void)drawLabels {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat gapHeightL = height/_leftLabels.count;
    for (int i = 0; i < _leftLabels.count; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + gapHeightL *i, 80, 30)];
        lab.text = _leftLabels[i];
        lab.textColor = __uiTextColor;
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
    }
    
    CGFloat gapHeightR = height/_rightLabels.count;
    for (int j = 0; j < _rightLabels.count; j ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(width-100, 0 + gapHeightR *j, 80, 30)];
        lab.text = _leftLabels[j];
        lab.textColor = __uiTextColor;
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
    }
}

- (void)drawRect:(CGRect)rect {
    [self drawUI];
    [self drawLabels];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.bounds.origin.x;
    
    CGFloat reX = x / _gapW;
    NSInteger shangX = (NSInteger)reX;
    if (reX - shangX > 0.5) {
        shangX = (shangX +1);
    }
    
    if (shangX >= _dataArr.count) {
        return;
    }
    [self showGrayLabelAniamtion:scrollView.bounds.size.height index:shangX];
//
//    WeightScaleModel *model = [_delegate grayLabelDidAnimationAtIndex:shangX];
//
//    NSMutableAttributedString *str = [self weightAttributeString:model.weight];
//    _weightLabel.attributedText = str;
//    _dateLabel.text = [NSString stringWithFormat:@"%@", [model.date dateToStringWithFormatter:@"yyyy-MM-dd HH:mm:ss"]];
}

- (void)showGrayLabelAniamtion:(CGFloat)scrollH index:(NSInteger)index {
    CGFloat yMax = [_coin yMax];
    CGFloat yMin = [_coin yMin];
    if (index >= _dataArr.count || index < 0 ) {
        return;
    }
    CGFloat ht = [[_dataArr objectAtIndex:index] floatValue];
    CGFloat y = (scrollH - 20) * (1- (ht - yMin)/(yMax - yMin)) + 10;
    [_grayLab setCenter:CGPointMake(_grayLab.center.x,y)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self endAnimation:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self endAnimation:scrollView];
}

- (void)endAnimation:(UIScrollView *)scrollView {
    CGFloat x = scrollView.bounds.origin.x;
    
    CGFloat reX = x / _gapW;
    NSInteger shangX = (NSInteger)reX;
    if (reX - shangX > 0.5) {
        shangX = (shangX +1);
    }
    
    if (shangX >= _dataArr.count) {
        shangX = _dataArr.count - 1;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [scrollView setContentOffset:CGPointMake(shangX *self->_gapW, scrollView.bounds.origin.y)];
    }];
//    WeightScaleModel *model = [_delegate grayLabelDidAnimationAtIndex:shangX];
//    NSMutableAttributedString *str = [self weightAttributeString:model.weight];
//    _weightLabel.attributedText = str;
//    _dateLabel.text = [NSString stringWithFormat:@"%@", [model.date dateToStringWithFormatter:@"yyyy-MM-dd HH:mm:ss"]];
    
    [_delegate scrollViewAnimationIsEndingAtIndex:shangX];
}

#pragma mark - Action
//
//- (NSMutableAttributedString *)weightAttributeString:(CGFloat)weight {
//    NSString *string = [NSString stringWithFormat:@"%.1f%@", weight, NSLocalizedString(@"kg", @"公斤")];
//    NSString *unit = NSLocalizedString(@"kg", @"公斤");
//    if ([Preferences shareInstance].unit==UnitImperial) {
//        weight = weight / 0.454;
//        string = [NSString stringWithFormat:@"%.1f%@", weight, NSLocalizedString(@"lbs", @"磅")];
//        unit = NSLocalizedString(@"lbs", @"磅");
//    }
//    NSMutableAttributedString *score = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont fontWithName:@"DINCond-Medium" size:FONT(25)]}];
//    UIFont *font = [UIFont systemFontOfSize:FONT(15)];
//    if (IOS9_UP) {
//        font = PingFang_SC_R(15);
//    }
//    [score addAttribute:NSFontAttributeName value:font range:NSMakeRange(string.length-unit.length, unit.length)];
//
//    return score;
//}


- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor direction:(NSInteger)direction {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (direction == 0) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (direction == 0) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(lineView.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
