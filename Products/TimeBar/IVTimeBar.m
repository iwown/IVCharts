//
//  IVTimeBar.m
//  IVCharts
//
//  Created by A$CE on 2019/6/4.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "IVTimeBar.h"

@implementation IVTimeBar {
    // 纵坐标最大范围
    NSInteger maxRangeTop;
    
    NSInteger _max;
    
    CGFloat _selfWidth;
    CGFloat _selfHeight;
    CGFloat _chartWidth;
    CGFloat _chartHeight;
    CGFloat _chartLeftGap;
    CGFloat _chartRightGap;
    CGFloat _chartBottomGap;
}

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initData];
    }
    return self;
}

- (void)setDataSource:(NSArray<NSNumber *> *)dataSource {
    _dataSource = dataSource;
    if (_maxValue > 0) {
        //如果已指定最大值，则不再动态计算最大值。
        return;
    }
    for (int i = 0; i < dataSource.count; i ++) {
        if ([dataSource[i] intValue] > _max) {
            _max = [dataSource[i] intValue];
        }
    }
}

- (void)setMaxValue:(NSInteger)maxValue {
    _maxValue = maxValue;
    _max = _maxValue;
}

- (void)setXLabels:(NSArray<NSString *> *)xLabels {
    _xLabels = xLabels;
}

- (void)initData {
    _max = 60;
    _xLabels = @[@"00:00",@"06:00",@"12:00",@"18:00"];
    self.barColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    self.lineColor = [UIColor whiteColor];
    self.barMirrorColor = [UIColor colorWithRed:0xdf/255.0 green:0xdf/255.0 blue:0xdf/255.0 alpha:0x33/255.0];
    
    IVSColor scColor = {0xee/255.0, 0xee/255.0, 0xee/255.0, 0x99/255.0};
    self.levelColor = scColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
    
    // Drawing code
    _selfWidth = rect.size.width;
    _selfHeight = rect.size.height;
    _chartLeftGap = 20;
    _chartRightGap = 20;
    _chartBottomGap = 30;
    _chartWidth = (_selfWidth - _chartLeftGap - _chartRightGap);
    _chartHeight = _selfHeight - _chartBottomGap;
    
    [self drawDayCaluse];
    [self drawDayTimeLine];
    [self drawDayCaluseDataView];
}

//画纵坐标
- (void)drawDayCaluse {
    NSInteger caluseMax=ceil(_max/5.0);
    if (caluseMax==0) {
        caluseMax=1;
    }
    maxRangeTop=caluseMax*5;
    
    if (self.numOfLevel > 0) {
        [self drawHorizontalLines];
    }
}

- (void)drawHorizontalLines {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, self.levelColor.red, self.levelColor.green, self.levelColor.blue, self.levelColor.alpha);
    CGFloat lengths[] = {2,5};
    if (self.dashLevel) {
        CGContextSetLineDash(context, 0, lengths,2);
    }else {
        CGContextSetLineDash(context, 0, lengths,0);
    }
    
    CGFloat unitHeight = _chartHeight/self.numOfLevel;
    for (int i = 0; i < self.numOfLevel; i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, _chartLeftGap,0 + i*unitHeight);//移动到指定位置（设置路径起点）
        CGPathAddLineToPoint(path, nil, _selfWidth-_chartRightGap, 0 + i*unitHeight);
        CGContextAddPath(context, path);
        CFRelease(path);
        CGContextStrokePath(context);
    }
}

//画横坐标
- (void)drawDayTimeLine {
    CGFloat xLineWidth = _chartWidth;
    CGFloat DayTimeLabDistance = xLineWidth/self.xLabels.count;
    for (int i = 0; i <self.xLabels.count; i++) {
        CGRect labelFrame = CGRectMake((_chartLeftGap+i*DayTimeLabDistance), (_selfHeight - _chartBottomGap), DayTimeLabDistance, 30);
        UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        label.text =self.xLabels[i];
        label.textColor = self.textColor;
        [self addSubview:label];
        
        if (self.showBottomLine) {
            UIView *shortLine = [[UIView alloc]initWithFrame:CGRectMake((_chartLeftGap+i*DayTimeLabDistance), (_selfHeight - _chartBottomGap), 1, 2)];
            shortLine.backgroundColor = self.lineColor;
            [self addSubview:shortLine];
        }
    }
    
    if (self.showBottomLine) {
        UIView *xCalurlesLine = [UIView new];
        [self addSubview:xCalurlesLine];
        xCalurlesLine.backgroundColor = self.lineColor;
        [xCalurlesLine setFrame:CGRectMake(_chartLeftGap, (_selfHeight - _chartBottomGap), xLineWidth, 1)];
    }
}

- (void)drawDayCaluseDataView {
    NSInteger count = self.dataSource.count;
    if (count == 0) {
        return;
    }
    //柱形图
    CGFloat heightTotal=_chartHeight;
    CGFloat widthPerHour=_chartWidth/(count*2 - 1);
    CGFloat maxNum = 0;
    NSInteger maxCount = 0;
    for (int i=0; i<count; ++i) {
        CGFloat n = [self.dataSource[i] floatValue];
        if (n>maxNum) {
            maxNum = n;
            maxCount = i;
        }
        
        UIView* tmp=[UIView new];
        tmp.backgroundColor=self.barColor;
  
        CGFloat tmpHeight=heightTotal*([self.dataSource[i] floatValue]/maxRangeTop);;
 
        CGFloat tmpY = _chartHeight - tmpHeight;
        CGRect rectTmp = CGRectMake(_chartLeftGap+(i*2)*widthPerHour, tmpY, widthPerHour, tmpHeight);
        [tmp setFrame:rectTmp];
        [self addSubview:tmp];
        
        if (self.showVisonalBar) {
            UIView* tmpS=[UIView new];
            tmpS.backgroundColor=self.barMirrorColor;
            
            CGRect rectTmpS = CGRectMake(_chartLeftGap+(i*2)*widthPerHour, 0, widthPerHour, tmpY);
            [tmpS setFrame:rectTmpS];
            [self addSubview:tmpS];
        }
        
        if (self.barGlColor) {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.frame = tmp.bounds;
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            gradientLayer.colors = [NSArray arrayWithObjects:(id)self.barColor.CGColor, (id)self.barGlColor.CGColor, nil];
            [tmp.layer insertSublayer:gradientLayer atIndex:0];
        }
    }
    
    if (_showBarValue) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat heightMax=heightTotal*(maxNum/maxRangeTop);;
        CGFloat maxY = _chartHeight - heightMax;
        CGRect rectMaxValue = CGRectMake(_chartLeftGap+(maxCount*2+0.5)*widthPerHour-15, maxY - 12, 30, 12);
        [label setTextAlignment:NSTextAlignmentCenter];
        label.frame = rectMaxValue;
        label.text = [NSString stringWithFormat:@"%ld",(long)maxNum];
        [self addSubview:label];
    }
}

- (void)gradientColor:(UIColor *)topC andEndColor:(UIColor *)bottomC {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)topC.CGColor, (id)bottomC.CGColor, nil];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


@end
