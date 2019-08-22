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
#define REDRAW_TAG 1234567809


@interface IVWeightLine ()<UIScrollViewDelegate> {
    
    UILabel *_grayLab;
    
    UIScrollView *_scroll;
    IVCoinLine *_coin;
    
    UIColor *__uiTextColor;
    UIColor *__uiTextGrayColor;
    UIColor *__uiLineColor;
    UIColor *__uiCoinColor;
    UIColor *__uiHighLightColor;
    UIColor *__uiGoalColor;
    UIColor *__uiBottomColor;

    NSInteger _scrollIndex;
    CGFloat _scrollHeight;
    CGFloat _scrollWidth;
    CGFloat _selfHeight;
    CGFloat _selfWidth;
    CGFloat _gapW;
    CGFloat _gapLeft;
}

@end


@implementation IVWeightLine

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initParam];
        [self initUI];
    }
    return self;
}

- (void)initParam {
    __uiTextColor = [UIColor whiteColor];
    __uiTextGrayColor = [UIColor colorWithWhite:1 alpha:0.5];
    __uiLineColor = [UIColor whiteColor];
    __uiCoinColor = [UIColor whiteColor];
    __uiHighLightColor = [UIColor whiteColor];
    __uiGoalColor = [UIColor whiteColor];
    __uiBottomColor = [UIColor whiteColor];
    _rightHighLightIndex = -1;
    
    _selfWidth = self.frame.size.width;
    _selfHeight = self.frame.size.height;
    _scrollHeight = _selfHeight;
    _scrollWidth = _selfWidth;
    _gapW = (_selfWidth / 9);
    _gapLeft = 50;
}

- (void)initUI {
    [self drawUI];
    self.userInteractionEnabled = YES;
}

- (void)setDataSource:(NSArray<NSNumber *> *)dataSource {
    _scrollIndex = dataSource.count - 1;
    _dataSource = dataSource;
}

- (void)setTextColor:(IVSColor)textColor {
    __uiTextColor = [UIColor colorWithRed:textColor.red green:textColor.green blue:textColor.blue alpha:textColor.alpha];
}

- (void)setTextGrayColor:(IVSColor)textGrayColor {
    __uiTextGrayColor = [UIColor colorWithRed:textGrayColor.red green:textGrayColor.green blue:textGrayColor.blue alpha:textGrayColor.alpha];
}

- (void)setLineColor:(IVSColor)lineColor {
    __uiLineColor = [UIColor colorWithRed:lineColor.red green:lineColor.green blue:lineColor.blue alpha:lineColor.alpha];
}

- (void)setCoinColor:(IVSColor)coinColor {
    __uiCoinColor = [UIColor colorWithRed:coinColor.red green:coinColor.green blue:coinColor.blue alpha:coinColor.alpha];
}

- (void)setHighLightColor:(IVSColor)highLightColor {
    __uiHighLightColor = [UIColor colorWithRed:highLightColor.red green:highLightColor.green blue:highLightColor.blue alpha:highLightColor.alpha];
}

- (void)setGoalColor:(IVSColor)goalColor {
    __uiGoalColor = [UIColor colorWithRed:goalColor.red green:goalColor.green blue:goalColor.blue alpha:goalColor.alpha];
}

- (void)setBottomLineColor:(IVSColor)bottomLineColor {
    __uiBottomColor = [UIColor colorWithRed:bottomLineColor.red green:bottomLineColor.green blue:bottomLineColor.blue alpha:bottomLineColor.alpha];
}

- (void)drawUI {
    CGFloat leftGap = (_selfWidth - _scrollWidth)/2;
    CGFloat topGap = (_selfHeight - _scrollHeight)/2;
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(leftGap, topGap, _scrollWidth, _scrollHeight)];
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.delegate = self;
    [self addSubview:_scroll];

    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((_selfWidth - _gapW) / 2, topGap, _gapW, _scroll.frame.size.height)];
    [img setBackgroundColor:[UIColor clearColor]];
    [self addSubview:img];
    
    _grayLab = [[UILabel alloc] init];
    [_grayLab setFrame:CGRectMake((_gapW-10) * 0.5, 0, 10, 10)];
    [_grayLab.layer setCornerRadius:5];
    [_grayLab setBackgroundColor:__uiHighLightColor];
    _grayLab.layer.masksToBounds = YES;
    _grayLab.layer.borderColor = __uiHighLightColor.CGColor;
    _grayLab.layer.borderWidth = 3;
    [img addSubview:_grayLab];
}

- (void)reDrawGoalGap {
    if (!_showGoal) {
        return;
    }
    for (UIView *vi in self.subviews) {
        if (vi.tag == REDRAW_TAG) {
            [vi removeFromSuperview];
        }
    }
    
    CGFloat height = _scrollHeight;
    
    CGFloat _target = [_delegate ivWeightLineTargetGoal];
    CGFloat maxY = _coin.yMax;
    CGFloat minY = _coin.yMin;
    CGFloat targetY = _scroll.frame.origin.y + (height - 20) * (1- (_target - minY)/(maxY - minY)) + 10;
    
    CGFloat ht = [_dataSource[_scrollIndex] floatValue];
    CGFloat theWeightY = _scroll.frame.origin.y + (height - 20) * (1- (ht - minY)/(maxY - minY)) + 10;
    CGFloat topY, gapHeight;
    if (_target >= ht) {
        topY = targetY;
        gapHeight = theWeightY - targetY;
    }else {
        topY = theWeightY;
        gapHeight = targetY - theWeightY;
    }
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake((_selfWidth - 1) / 2, topY, 1, gapHeight)];
    [self drawDashLine:centerLine lineLength:2 lineSpacing:6 lineColor:[UIColor redColor] direction:1];
    [centerLine setTag:REDRAW_TAG];
    [self addSubview:centerLine];
    
    UILabel *_spaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_selfWidth / 2 + 5, topY, 100, 30)];
    _spaceLabel.center = CGPointMake(_spaceLabel.center.x, topY+gapHeight/2);
    _spaceLabel.font = [UIFont systemFontOfSize:13];
    _spaceLabel.textColor = [UIColor whiteColor];
    _spaceLabel.tag = REDRAW_TAG;
    _spaceLabel.text = [_delegate ivWeightLineCurrentTargetGapText];
    
    [self addSubview:_spaceLabel];
}

- (void)reDrawGoal {
    if (!_showGoal) {
        return;
    }
    CGFloat width = _scroll.frame.size.width;
    CGFloat height = _scroll.frame.size.height;
    
    CGFloat _target = [_delegate ivWeightLineTargetGoal];
    CGFloat maxY = _coin.yMax;
    CGFloat minY = _coin.yMin;
    CGFloat targetY = _scroll.frame.origin.y + (height - 20) * (1- (_target - minY)/(maxY - minY)) + 10;
    
    UILabel *targetLabel = [[UILabel alloc] initWithFrame:CGRectMake(_selfWidth - 100 - _gapLeft, targetY - 30, 100, 30)];
    targetLabel.tag = REMOVE_TAG;
    targetLabel.text = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Goal", @"目标体重"), [_delegate ivWeightLineTargetGoalText]];
    targetLabel.textColor = __uiTextColor;
    targetLabel.font = [UIFont systemFontOfSize:13];
    targetLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:targetLabel];
    
    UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(_gapLeft, targetY, width, 1)];
    vLine.tag = REMOVE_TAG;
    vLine.backgroundColor = __uiGoalColor;
    [self addSubview:vLine];
    
    UIView *botLine = [[UIView alloc] initWithFrame:CGRectMake(_gapLeft, _selfHeight-15, width, 1)];
    [self drawDashLine:botLine lineLength:6 lineSpacing:4 lineColor:__uiBottomColor direction:0];
    botLine.tag = REMOVE_TAG;
    [self addSubview:botLine];
}

- (void)reDrawLine {
    CGFloat width = _scroll.frame.size.width;
    CGFloat height = _scroll.frame.size.height;
    
    _coin = [[IVCoinLine alloc] initWithFrame:CGRectMake(width / 2, 0, _gapW * (_dataSource.count - 1), height) gapW:_gapW maxY:height];
    _coin.tag = REMOVE_TAG;
    _coin.lineColor = __uiLineColor;
    _coin.coinColor = __uiCoinColor;
    [_scroll addSubview:_coin];
    
    [_scroll setContentOffset:CGPointMake((_dataSource.count-1) *_gapW, _scroll.bounds.origin.y)];
    [_scroll setContentSize:CGSizeMake(_gapW * (_dataSource.count - 1) + width, height)];
    
    [_coin setArr:_dataSource];
    
    [self showGrayLabelAniamtion:_scroll.bounds.size.height index:_dataSource.count -1];
    [self endAnimation:_scroll];
}

- (void)reDrawLabels {
    CGFloat width = _selfWidth;
    CGFloat height = _selfHeight;
    
    CGFloat gapHeightL = height/_leftLabels.count;
    for (int i = 0; i < _leftLabels.count; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + gapHeightL *i, _gapLeft, 30)];
        lab.text = _leftLabels[i];
        lab.textColor = __uiTextColor;
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        lab.tag = REMOVE_TAG;
        [self addSubview:lab];
    }
    
    CGFloat gapHeightR = height/_rightLabels.count;
    for (int j = 0; j < _rightLabels.count; j ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(width-20-_gapLeft, 0 + gapHeightR *j, _gapLeft, 30)];
        lab.text = _rightLabels[j];
        if (_rightHighLightIndex == j) {
            lab.textColor = __uiTextColor;
        }else {
            lab.textColor = __uiTextGrayColor;
        }
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:14];
        lab.tag = REMOVE_TAG;
        [self addSubview:lab];
    }
}

- (void)drawRect:(CGRect)rect {
    for (UIView *vi in _scroll.subviews) {
        if (vi.tag == REMOVE_TAG) {
            [vi removeFromSuperview];
        }
    }
    for (UIView *vi in self.subviews) {
        if (vi.tag == REMOVE_TAG) {
            [vi removeFromSuperview];
        }
    }
    [self reDrawLabels];
    [self reDrawLine];
    [self reDrawGoal];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.bounds.origin.x;
    
    CGFloat reX = x / _gapW;
    NSInteger shangX = (NSInteger)reX;
    if (reX - shangX > 0.5) {
        shangX = (shangX +1);
    }
    
    if (shangX >= _dataSource.count || shangX < 0 || _scrollIndex == shangX) {
        return;
    }
    _scrollIndex = shangX;
    [self showGrayLabelAniamtion:scrollView.bounds.size.height index:shangX];
}

- (void)showGrayLabelAniamtion:(CGFloat)scrollH index:(NSInteger)index {
    CGFloat yMax = [_coin yMax];
    CGFloat yMin = [_coin yMin];
    if (index >= _dataSource.count || index < 0 ) {
        return;
    }
    CGFloat ht = [_dataSource[index] integerValue];
    CGFloat y = (scrollH - 20) * (1- (ht - yMin)/(yMax - yMin)) + 10;
    [_grayLab setCenter:CGPointMake(_grayLab.center.x,y)];
    [self reDrawGoalGap];
    
    [_delegate ivWeightLineScrollAtIndex:_scrollIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self endAnimation:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self endAnimation:scrollView];
}

- (void)endAnimation:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.2 animations:^{
        [scrollView setContentOffset:CGPointMake(self->_scrollIndex *self->_gapW, scrollView.bounds.origin.y)];
        [self showGrayLabelAniamtion:scrollView.bounds.size.height index:self->_scrollIndex];
    }];
}

#pragma mark - Action
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor direction:(NSInteger)direction {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:lineColor.CGColor];
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
