//
//  UnilateralChart.m
//  TestChar
//
//  Created by 曹凯 on 2017/7/5.
//  Copyright © 2017年 Iwown. All rights reserved.
//

#import "IVSportsCurve.h"
#import "ConstAndStruct.h"

//table view cell 宽度不会占满10个像素
#define cell_WIDTH (IVC_SCREEN_WIDTH-10)
#define lMargin cell_WIDTH*0.05
#define leftWidth lMargin*1.5
#define rightWidth lMargin*1
#define KWIDTH (cell_WIDTH - leftWidth - rightWidth)
#define HEIGHT_SCALE IVC_SCREEN_HEIGHT/667.0
#define CHART_TOTAL 44*5*HEIGHT_SCALE
#define TOP_GAP 10

@implementation IVSportsCurve {
    NSMutableArray  *_arr;
    NSMutableArray  *_anchorPoints;
    
    int _yMax;
    int _yMin;
    
    IVSCDashMarkLine *_markLine;
    UIView *_cicleView;
    
    int  _lineNumber;
}

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _ascend = YES;
        _hrScale = 1;
        _lineNumber = 5;
        _arr = [NSMutableArray arrayWithCapacity:0];
        _anchorPoints = [NSMutableArray arrayWithCapacity:0];
        _markLine = [[IVSCDashMarkLine alloc] init];
        _cicleView = [[UIView alloc] init];
        _cicleView.backgroundColor = [UIColor colorWithRed:0x11/255.0 green:0x7A/255.0 blue:0xFF/255.0 alpha:1];
        [self addSubview:_markLine];
        [self addSubview:_cicleView];
    }
    return self;
}

- (void)setDataSource:(NSArray <NSValue *>*)arr {
    NSArray *tmpArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSValue *value1 = (NSValue *)obj1;
        NSValue *value2 = (NSValue *)obj2;
        CGPoint point1 = [value1 CGPointValue];
        CGPoint point2 = [value2 CGPointValue];
        if (point1.x > point2.x) {
            return NSOrderedDescending;
        }else if (point1.x == point2.x) {
            return NSOrderedSame;
        }else {
            return NSOrderedAscending;
        }
    }];
    
    [_arr removeAllObjects];
    [_arr addObjectsFromArray:tmpArr];
    if (_arr.count > 0) {
        [self parseYMaxAndMin];
        [self addLeftView:[self getLeftTitles]];
    }
}

- (NSArray *)getBottomTitles {
    int gap = _maxX / 6;
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i < 7; i ++) {
        int num = gap * i;
        NSString *title = [NSString stringWithFormat:@"%d",num];
        if (i == 6) {
            title = NSLocalizedString(@"min", nil) ;
        }
        [mArr addObject:title];
    }
    return mArr;
}

- (NSArray *)getLeftTitles {
    int gap = (_yMax - _yMin) / _lineNumber;
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    int flag = 0;
    int minus = 0;
    if (_ascend) {
        flag = 1;
        minus = _yMin;
    }else {
        flag = -1;
        minus = _yMax;
    }
    for (int i = 0; i <= _lineNumber; i ++) {
        int num = minus + (gap * i * flag);
        NSString *title = [NSString stringWithFormat:@"%d",num];
        [mArr insertObject:title atIndex:0];
    }
    return mArr;
}

- (void)setMaxX:(CGFloat)maxX {
    int intMax = (int)maxX;
    int maxSix = intMax/6;
    if (maxX == (maxSix * 6)) {
        _maxX = (int)maxX;
    }else {
        _maxX = 6 * (maxSix + 1);
    }
    [self addBottomView:[self getBottomTitles]];
}

- (void)parseYMaxAndMin {
    CGPoint firstP = [[_arr firstObject] CGPointValue];
    float maxX = firstP.x;
    float max = firstP.y;
    float min = max;
    for (NSValue *numPoint in _arr) {
        CGPoint num = [numPoint CGPointValue];
        float valueX = num.x;
        if (maxX < valueX) {
            maxX = valueX;
        }
        
        float valueY = num.y;
        if (max < valueY) {
            max = valueY;
        }else if(min > valueY){
            min = valueY;
        }
    }
    int intMax = (int)max;
    int maxFive = intMax/_lineNumber;
    if (max == (maxFive * _lineNumber)) {
        _yMax = (int)max;
    }else {
        _yMax = _lineNumber * (maxFive + 2);
    }
    
    int intMin = (int)min;
    int minFive = intMin/_lineNumber;
    _yMin = minFive * _lineNumber;
    
    if (_yMax == _yMin) {
        _yMax += _lineNumber;
        _yMin -= _lineNumber;
        if (_yMin < 0 ) {
            _yMin = 0;
        }
    }
    
    [self setMaxX:maxX];
}

- (void)addLeftView:(NSArray *)leftTitles {
    CGFloat unitHeight = CHART_TOTAL/_lineNumber;
    for (int i = 0; i < leftTitles.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWidth, 10*_hrScale)];
        CGFloat hetight = TOP_GAP + i*unitHeight*_hrScale;
        [label setCenter:CGPointMake(leftWidth/2.0, hetight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = leftTitles[i];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    }
}

- (void)addBottomView:(NSArray <NSString *>*)bottomTitles {
    if (bottomTitles.count < 2) {
        return;
    }
    CGFloat kWidth = KWIDTH;
    CGFloat width = kWidth/(bottomTitles.count-1);
    for (int i = 0; i < bottomTitles.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWidth, 10*_hrScale)];
        CGFloat hetight = TOP_GAP + (CHART_TOTAL + 10)*_hrScale;
        CGFloat lWidth = leftWidth + i * width;
        [label setCenter:CGPointMake(lWidth , hetight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = bottomTitles[i];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    [self drawHorizontalLines:context];
    CGPoint lastP = [_arr.lastObject CGPointValue];
    if ( lastP.x <= 0) {
        return;
    }
    if (_arr.count > 0) {
        [self drawHrLine:context];
    }
    [_markLine setFrame:CGRectMake(0, TOP_GAP, 1.5, CHART_TOTAL * _hrScale)];
    _markLine.hidden = YES;
    [_cicleView setFrame:CGRectMake(0, 0, 6, 6)];
    _cicleView.layer.cornerRadius = 3.0;
    _cicleView.layer.masksToBounds = YES;
    _cicleView.layer.borderWidth = 2;
    _cicleView.layer.borderColor = [UIColor grayColor].CGColor;
    _cicleView.hidden = YES;
}

- (void)drawHorizontalLines:(CGContextRef)context {
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, _hrScale);
    CGContextSetRGBStrokeColor(context, 0xff/255.0, 0xff/255.0, 0xff/255.0, 0.5);
    CGFloat lengths[] = {2,5};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGFloat unitHeight = CHART_TOTAL/_lineNumber;
    for (int i = 0; i < _lineNumber+1; i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, leftWidth,TOP_GAP + i*unitHeight*_hrScale);//移动到指定位置（设置路径起点）
        CGPathAddLineToPoint(path, nil, self.frame.size.width-rightWidth, TOP_GAP + i*unitHeight*_hrScale);
        CGContextAddPath(context, path);
        CFRelease(path);
        if (i == _lineNumber) {
            CGContextSetLineDash(context, 0, lengths,0);
        }
        CGContextStrokePath(context);
    }
}

- (void)drawHrLine:(CGContextRef)context {
    CGFloat height = CHART_TOTAL * _hrScale;
    float gapH = height / (_yMax - _yMin);
    
    CGFloat kWidth = KWIDTH;
    CGFloat unitWidth = kWidth/_maxX; //1个横向单位宽度
    
    int flag = 0;
    int baseH = 0;
    if (_ascend) {
        flag = -1;
        baseH = height;
    }else {
        flag = 1;
        baseH = 0;
    }
   
    [_anchorPoints removeAllObjects];
    for (int i = 0; i<[_arr count]; i++) {
        CGPoint tmpP = [_arr[i] CGPointValue];
        CGFloat py = tmpP.y;
        CGFloat gapY = py - _yMin;
        CGFloat px = tmpP.x;
        CGPoint p = CGPointMake(leftWidth + px * unitWidth,TOP_GAP + baseH+flag*gapY*gapH);
        [_anchorPoints addObject:[NSValue valueWithCGPoint:p]];
    }
    [self smoothedPathWithPoints:_anchorPoints andGranularity:_maxX];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self moveMarkView:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self moveMarkView:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [_markLine setHidden:YES];
    [_cicleView setHidden:YES];
}

- (void)moveMarkView:(CGPoint)point {
    if (_arr.count == 0) {
        return;
    }
    
    CGPoint viewPoint = CGPointZero;
    float gap = point.x;
    int index = 0;
    for (int i = 0; i < _anchorPoints.count; i ++) {
        NSValue *value = _anchorPoints[i];
        float tGap = ABS(value.CGPointValue.x - point.x);
        if (tGap <= gap) {
            gap = tGap;
            viewPoint = value.CGPointValue;
            index = i;
        }else {
            break;
        }
    }
    
    if (viewPoint.x == 0 && viewPoint.y == 0) {
        return;
    }
    
    [_cicleView setCenter:viewPoint];
    [_cicleView setHidden:NO];
    [_markLine setCenter:CGPointMake(viewPoint.x, CHART_TOTAL * _hrScale * 0.5)];
    [_markLine setHidden:NO];
    CGPoint thePoint = [_arr[index] CGPointValue];
    if ([self.delegate respondsToSelector:@selector(showTextOnSpecialPoint:)]) {
        _markLine.titleLabel.text = [self.delegate showTextOnSpecialPoint:thePoint];
    }else {
        _markLine.titleLabel.text = [NSString stringWithFormat:@"%d,%.1f",(int)thePoint.x,thePoint.y];
    }
}

#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]
- (void)smoothedPathWithPoints:(NSArray *)pointsArray andGranularity:(NSInteger)granularity {
    NSMutableArray *points = [pointsArray mutableCopy];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0x13/255.0 green:0x74/255.0 blue:0xd4/255.0 alpha:1].CGColor);
    CGContextSetLineWidth(context, 2);
    
    UIBezierPath *smoothedPath = [UIBezierPath bezierPath];
    
    // Add control points to make the math make sense
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    [smoothedPath moveToPoint:POINT(0)];
    
    for (int index = 1; index < points.count - 2; index ++) {
        CGPoint p1 = POINT(index);
        CGPoint p2 = POINT(index + 1);
        CGPoint pE = CGPointMake((p1.x+p2.x)/2.0, (p1.y+p2.y)/2.0);
        [smoothedPath addQuadCurveToPoint:pE controlPoint:p1];
    }
    
    // finish by adding the last point
    [smoothedPath addLineToPoint:POINT(points.count - 1)];

    CGContextAddPath(context, smoothedPath.CGPath);
    CGContextDrawPath(context, kCGPathStroke);
}

@end


@implementation IVSCDashMarkLine

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:20];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat rectW = self.frame.size.width;
    CGFloat rectH = self.frame.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, rectW);
    CGContextSetRGBStrokeColor(context, 0x4a/255.0, 0x4b/255.0, 0x4d/255.0, 1);
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(context, 0, lengths,2);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, 0, rectH);
    CGContextAddPath(context, path);
    CFRelease(path);
    CGContextStrokePath(context);
    
    self.titleLabel.frame = CGRectMake(-50, -25, 100+rectW, 25);
}

@end




