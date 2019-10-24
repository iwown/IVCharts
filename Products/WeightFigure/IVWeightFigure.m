//
//  IVWeightFigure.m
//  IVCharts
//
//  Created by A$CE on 2019/9/5.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "IVWeightFigure.h"

@implementation IVWeightFigure
{
    CGFloat __selfWidth;
    CGFloat __selfHeight;
    
    UIColor *__uiTextColor;
    UIColor *__uiGrayColor;
    
    UIView *_bgView;
    
    UILabel *_bmiLabel;
    UILabel *_bfLabel;
    
    CGFloat gapHeightL;
    CGFloat grayLabelWidth;
    CGFloat grayLabelHeight;
    
    CGFloat chartWidth;
    CGFloat chartHeight;
    
    CGFloat length122;
    CGFloat length60;
    CGFloat breadth62;
    CGFloat breadth75;
    CGFloat breadth64;
    CGFloat breadth140;
    CGFloat breadth138;
}

- (void)reloadData {
    _bmiLabel.text = [NSString stringWithFormat:@"%.1f",_weightFigure.bmi];
    _bfLabel.text = [NSString stringWithFormat:@"%.1f%%",_weightFigure.body_fat];
    
    [self reDrawPoint];
    [self showHighLabel];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        __selfWidth = frame.size.width;
        __selfHeight = frame.size.height;
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData {
    __uiTextColor = [UIColor colorWithRed:0x4A/255.0 green:0x4B/255.0 blue:0x4D/255.0 alpha:1];
    __uiGrayColor = [UIColor colorWithRed:0xB3/255.0 green:0xB3/255.0 blue:0xB3/255.0 alpha:1];
    
    gapHeightL = 30;
    grayLabelWidth = 0.1301 * __selfWidth;
    grayLabelHeight = 20;
    
    chartWidth = 0.816 * __selfWidth;
    chartHeight = (__selfHeight - (gapHeightL * 2 + grayLabelHeight));

    length122 = 0.3987 * chartWidth;
    length60 = 0.1961 * chartWidth;
    breadth62 = 0.2330 * chartHeight;
    breadth75 = 0.2820 * chartHeight;
    breadth64 = 0.2406 * chartHeight;
    breadth140 = 0.5263 * chartHeight;
    breadth138 = 0.5188 * chartHeight;
}

static int BG_CHART_TAG = 1409;
- (void)initUI {
    self.backgroundColor = [UIColor clearColor];
    
    //Draw Title Label
    UILabel *bmiTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, grayLabelWidth, gapHeightL)];
    [bmiTitle setTextAlignment:NSTextAlignmentRight];
    [bmiTitle setTextColor:__uiGrayColor];
    [bmiTitle setText:@"BMI:"];
    [bmiTitle setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:bmiTitle];
    
    _bmiLabel = [[UILabel alloc] initWithFrame:CGRectMake(grayLabelWidth, 0, grayLabelWidth, gapHeightL)];
    [_bmiLabel setTextAlignment:NSTextAlignmentCenter];
    [_bmiLabel setTextColor:__uiTextColor];
    [_bmiLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_bmiLabel];
    
    UILabel *bfTitle = [[UILabel alloc] initWithFrame:CGRectMake(grayLabelWidth, gapHeightL + grayLabelHeight + chartHeight, 100, gapHeightL)];
    [bfTitle setTextAlignment:NSTextAlignmentLeft];
    [bfTitle setTextColor:__uiGrayColor];
    [bfTitle setText:NSLocalizedString(@"体内脂肪含量:", nil)];
    [bfTitle setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:bfTitle];
    
    _bfLabel = [[UILabel alloc] initWithFrame:CGRectMake(grayLabelWidth+100, gapHeightL + grayLabelHeight + chartHeight, 80, gapHeightL)];
    [_bfLabel setTextAlignment:NSTextAlignmentLeft];
    [_bfLabel setTextColor:__uiTextColor];
    [_bfLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_bfLabel];
    
    //Draw Charts BG
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(grayLabelWidth, gapHeightL, chartWidth, chartHeight)];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    [[_bgView layer] setMasksToBounds:YES];
    [[_bgView layer] setCornerRadius:8];
    [self addSubview:_bgView];
    
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, length122, breadth62)];
    [labelA setBackgroundColor:[UIColor colorWithRed:0 green:0x9D/255.0 blue:0xC4/255.0 alpha:1]];
    [labelA setTextAlignment:NSTextAlignmentCenter];
    [labelA setText:NSLocalizedString(@"运动员体制", nil)];
    [labelA setFont:[UIFont systemFontOfSize:14]];
    [labelA setTextColor:[UIColor whiteColor]];
    [labelA setTag:BG_CHART_TAG];
    [_bgView addSubview:labelA];
    
    UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(length122 + 1, 0, length60, breadth62)];
    [labelB setBackgroundColor:[UIColor colorWithRed:0xE3/255.0 green:0x11/255.0 blue:0x43/255.0 alpha:1]];
    [labelB setTextAlignment:NSTextAlignmentCenter];
    [labelB setText:NSLocalizedString(@"丰满", nil)];
    [labelB setFont:[UIFont systemFontOfSize:14]];
    [labelB setTextColor:[UIColor whiteColor]];
    [labelB setTag:BG_CHART_TAG + 1];
    [_bgView addSubview:labelB];
    
    UILabel *labelC = [[UILabel alloc] initWithFrame:CGRectMake(length122 + 2 + length60, 0, length122, breadth62)];
    [labelC setBackgroundColor:[UIColor colorWithRed:0xD5/255.0 green:0xA7/255.0 blue:0x06/255.0 alpha:1]];
    [labelC setTextAlignment:NSTextAlignmentCenter];
    [labelC setText:NSLocalizedString(@"肥胖", nil)];
    [labelC setFont:[UIFont systemFontOfSize:14]];
    [labelC setTextColor:[UIColor whiteColor]];
    [labelC setTag:BG_CHART_TAG + 2];
    [_bgView addSubview:labelC];
    
    UILabel *labelD = [[UILabel alloc] initWithFrame:CGRectMake(0, breadth62 + 1, length122, breadth62)];
    [labelD setBackgroundColor:[UIColor colorWithRed:0xD3/255.0 green:0x58/255.0 blue:0 alpha:1]];
    [labelD setTextAlignment:NSTextAlignmentCenter];
    [labelD setText:NSLocalizedString(@"肌肉型体质", nil)];
    [labelD setFont:[UIFont systemFontOfSize:14]];
    [labelD setTextColor:[UIColor whiteColor]];
    [labelD setTag:BG_CHART_TAG + 3];
    [_bgView addSubview:labelD];
    
    UILabel *labelE = [[UILabel alloc] initWithFrame:CGRectMake(0, breadth62 + 2 + breadth62, length122, breadth75)];
    [labelE setBackgroundColor:[UIColor colorWithRed:0x07/255.0 green:0xCB/255.0 blue:0xA6/255.0 alpha:1]];
    [labelE setTextAlignment:NSTextAlignmentCenter];
    [labelE setText:NSLocalizedString(@"太瘦", nil)];
    [labelE setFont:[UIFont systemFontOfSize:14]];
    [labelE setTextColor:[UIColor whiteColor]];
    [labelE setTag:BG_CHART_TAG + 4];
    [_bgView addSubview:labelE];
    
    UILabel *labelF = [[UILabel alloc] initWithFrame:CGRectMake(length122 + 1, breadth62 + 1, length60, breadth138)];
    [labelF setBackgroundColor:[UIColor colorWithRed:0x2D/255.0 green:0xB4/255.0 blue:0x07/255.0 alpha:1]];
    [labelF setTextAlignment:NSTextAlignmentCenter];
    [labelF setText:NSLocalizedString(@"正常", nil)];
    [labelF setFont:[UIFont systemFontOfSize:14]];
    [labelF setTextColor:[UIColor whiteColor]];
    [labelF setTag:BG_CHART_TAG + 5];
    [_bgView addSubview:labelF];
    
    UILabel *labelG = [[UILabel alloc] initWithFrame:CGRectMake(length122 + 2 + length60, breadth62 + 1, length122, breadth62)];
    [labelG setBackgroundColor:[UIColor colorWithRed:0xBB/255.0 green:0x05/255.0 blue:0x72/255.0 alpha:1]];
    [labelG setTextAlignment:NSTextAlignmentCenter];
    [labelG setText:NSLocalizedString(@"丰满", nil)];
    [labelG setFont:[UIFont systemFontOfSize:14]];
    [labelG setTextColor:[UIColor whiteColor]];
    [labelG setTag:BG_CHART_TAG + 6];
    [_bgView addSubview:labelG];
    
    UILabel *labelH = [[UILabel alloc] initWithFrame:CGRectMake(0, breadth62 + 3 + breadth62 + breadth75, length60, breadth64)];
    [labelH setBackgroundColor:[UIColor colorWithRed:0xA8/255.0 green:0xA8/255.0 blue:0xA8/255.0 alpha:1]];
    [labelH setTextAlignment:NSTextAlignmentCenter];
    [labelH setText:NSLocalizedString(@"太瘦", nil)];
    [labelH setFont:[UIFont systemFontOfSize:14]];
    [labelH setTextColor:[UIColor whiteColor]];
    [labelH setTag:BG_CHART_TAG + 7];
    [_bgView addSubview:labelH];
    
    UILabel *labelI = [[UILabel alloc] initWithFrame:CGRectMake(length60 + 1, breadth62 + 3 + breadth62 + breadth75, length122, breadth64)];
    [labelI setBackgroundColor:[UIColor colorWithRed:0x07/255.0 green:0x4C/255.0 blue:0xB7/255.0 alpha:1]];
    [labelI setTextAlignment:NSTextAlignmentCenter];
    [labelI setText:NSLocalizedString(@"偏瘦体型", nil)];
    [labelI setFont:[UIFont systemFontOfSize:14]];
    [labelI setTextColor:[UIColor whiteColor]];
    [labelI setTag:BG_CHART_TAG + 8];
    [_bgView addSubview:labelI];
    
    UILabel *labelJ = [[UILabel alloc] initWithFrame:CGRectMake(length122 + 2 + length60, breadth62 + 2 + breadth62, length122, breadth140)];
    [labelJ setBackgroundColor:[UIColor colorWithRed:0x97/255.0 green:0x06/255.0 blue:0xC0/255.0 alpha:1]];
    [labelJ setTextAlignment:NSTextAlignmentCenter];
    [labelJ setText:NSLocalizedString(@"隐藏性\n肥胖", nil)];
    [labelJ setFont:[UIFont systemFontOfSize:14]];
    [labelJ setTextColor:[UIColor whiteColor]];
    [labelJ setTag:BG_CHART_TAG + 9];
    [labelJ setNumberOfLines:0];
    [_bgView addSubview:labelJ];
    
    //Draw Labels;
    NSArray *leftLabels = @[@{@"text":@"30.0",@"y":@(0)},
                            @{@"text":@"25.0",@"y":@(19.55)},
                            @{@"text":@"21.75",@"y":@(43.23)},
                            @{@"text":@"18.5",@"y":@(71.80)}];
    for (int i = 0; i < leftLabels.count; i ++) {
        CGFloat y = [[leftLabels[i] objectForKey:@"y"] floatValue];
        CGFloat height = gapHeightL + y * 0.01 * chartHeight;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + height, grayLabelWidth, 30)];
        lab.text = [leftLabels[i] objectForKey:@"text"];
        lab.textColor = __uiGrayColor;
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:12];
        [self addSubview:lab];
    }
    
    CGFloat gapRight = __selfWidth * 0.0533;
    CGFloat gapHeightR = (__selfWidth-grayLabelWidth-gapRight)/5;
    for (int j = 0; j < 6; j ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(grayLabelWidth + (j+0.5) * gapHeightR, gapHeightL + chartHeight, gapHeightR, 30)];
        lab.text = [NSString stringWithFormat:@"%ld%%",(long)(j+2)*5];
        lab.textColor = __uiGrayColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        [self addSubview:lab];
    }
}

static int REMOVE_TAG = 1298;
- (void)reDrawPoint {
    for (UIView *vi in self.subviews) {
        if (vi.tag == REMOVE_TAG) {
            [vi removeFromSuperview];
        }
    }
    
    CGFloat point_cx = 0;
    CGFloat point_cy = 0;
    
    if (_weightFigure.bmi <= 18.5) {
        point_cy = gapHeightL + breadth62 + 3 + breadth62 + breadth75 + breadth64 * (18.5-_weightFigure.bmi)/18.5;
    }else if (_weightFigure.bmi <= 21.75) {
        point_cy = gapHeightL + breadth62 + 2 + breadth62 + breadth75 * (21.75-_weightFigure.bmi)/(21.75-18.5);
    }else if (_weightFigure.bmi <= 25.0) {
        point_cy = gapHeightL + breadth62 + 1 + breadth62 * (25.0-_weightFigure.bmi)/(25.0-21.75);
    }else if (_weightFigure.bmi <= 30.0) {
        point_cy = gapHeightL + breadth62 * (30.0-_weightFigure.bmi)/(30.0-25.0);
    }else {
        point_cy = gapHeightL;
    }
    
    if (_weightFigure.body_fat <= 10) {
        point_cx = grayLabelWidth + (length60/10.0 * _weightFigure.body_fat);
    }else if (_weightFigure.body_fat < 30) {
        point_cx = grayLabelWidth + length60 + (chartWidth - length60)/20.0 * (_weightFigure.body_fat - 10);
    }else {
        point_cx = grayLabelWidth + chartWidth;
    }

    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9, 9)];
    [pointView setBackgroundColor:[UIColor whiteColor]];
    [[pointView layer] setMasksToBounds:YES];
    [[pointView layer] setCornerRadius:4.5];
    [pointView setCenter:CGPointMake(point_cx, point_cy)];
    [self addSubview:pointView];
    
    IVDashLineView *vLine = [[IVDashLineView alloc] initWithFrame:CGRectMake(point_cx, point_cy, 2, chartHeight-point_cy + gapHeightL)];
    [vLine setDirection:vertical];
    [vLine setTag:REMOVE_TAG];
    [self addSubview:vLine];
    
    IVDashLineView *hLine = [[IVDashLineView alloc] initWithFrame:CGRectMake(grayLabelWidth, point_cy, point_cx-grayLabelWidth, 2)];
    [hLine setTag:REMOVE_TAG];
    [self addSubview:hLine];
}

- (void)showHighLabel {
    NSInteger highLightTag = [self pointLabelTag] + BG_CHART_TAG;
    for (UIView *view in _bgView.subviews) {
        if (highLightTag == view.tag) {
            view.alpha = 1;
        }else {
            view.alpha = 0.15;
        }
    }
}

typedef struct {
    float low_bmi;
    float top_bmi;
    float low_bf_X;
    float top_bf_X;
    int tag_lab;
}WFRange;

static WFRange rangers[10] = {
    {0, 18.5, 0, 0.1961, 7},
    {0, 18.5, 0.1961, 0.5980, 8},
    {18.5, 21.75, 0, 0.3987, 4},
    {18.5, 21.75, 0.5980, 1, 9},
    {18.5, 25.0, 0.3987, 0.5980, 5},
    {21.75, 25.0, 0, 0.3987, 3},
    {21.75, 25.0, 0.5980, 1, 6},
    {25.0, 100.0, 0, 0.3987, 0},
    {25.0, 100.0, 0.3987, 0.5980, 1},
    {25.0, 100.0, 0.5980, 1, 2},
};

- (NSInteger)pointLabelTag {
    CGFloat bimValue = _weightFigure.bmi;
    CGFloat bf_XValue = 0;
    
    if (_weightFigure.body_fat <= 10) {
        bf_XValue = (length60/chartWidth * _weightFigure.body_fat/10.0);
    }else if (_weightFigure.body_fat < 30) {
        bf_XValue = (length60 + (_weightFigure.body_fat-10)/20.0*(chartWidth-length60))/chartWidth;
    }
    
    if (bf_XValue > 1) {
        bf_XValue = 1;
    }
    
    NSInteger tag = -1;
    for (int i = 0; i < 10; i ++) {
        WFRange range = rangers[i];
        if (bimValue > range.low_bmi &&
            bimValue <= range.top_bmi &&
            bf_XValue > range.low_bf_X &&
            bf_XValue <= range.top_bf_X) {
            tag = range.tag_lab;
            break;
        }
    }
    if (tag == -1) {
        NSLog(@"这里有bug，快去查！！！");
    }else {
        _figureBody = [self figureBodyArr][tag];
    }
    return tag;
}

- (NSArray *)figureBodyArr {
    return @[@"运动员体制",@"丰满",@"肥胖",@"肌肉型体质",
             @"太瘦",@"正常",@"丰满",@"太瘦",@"偏瘦体型",
             @"隐藏性\n肥胖"];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


@end


@implementation IVDashLineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();//获取绘图用的图形上下文
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);//填充色设置成
    CGFloat lengths[] = {4};
    CGContextSetLineDash(context, 4, lengths,1);
    
    CGContextFillRect(context,self.bounds);//把整个空间用刚设置的颜色填充
    //上面是准备工作，下面开始画线了
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);//设置线的颜色
    CGContextMoveToPoint(context,0,0);//画线的起始点位置
    //画第一条线的终点位置
    if (self.direction == vertical) {
        CGContextAddLineToPoint(context,0,self.frame.size.height);
    }else {
        CGContextAddLineToPoint(context,self.frame.size.width,0);
    }
    CGContextStrokePath(context);//把线在界面上绘制出来
}


@end


