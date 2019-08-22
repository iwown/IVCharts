//
//  IVCoinLine.m
//  linyi
//
//  Created by west on 2017/8/22.
//  Copyright © 2017年 com.kunekt.healthy. All rights reserved.
//

#import "IVCoinLine.h"
#import "ConstAndStruct.h"

#define BEZIER_PATH_GRANULARITY 40
#define BEZIER_PATH_WIDTH 2


@implementation IVCoinLine
{
    CGFloat         _width;
    CGFloat         _height;
    CGFloat         _yMin;
    CGFloat         _yMax;
    CGFloat         _gapW;
    CGFloat         _gapH;
    CGFloat         _target;
    NSArray         *_arr;
}

- (instancetype)initWithFrame:(CGRect)frame gapW:(CGFloat)gapW maxY:(CGFloat)maxY {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _width = frame.size.width;
        _height = frame.size.height;
        _gapW = gapW;
        _yMax = maxY;
        _yMin = 10;
    }
    return self;
}

- (NSInteger)yMax {
    return _yMax;
}

- (NSInteger)yMin {
    return _yMin;
}

- (void)setArr:(NSArray *)arr {
    _arr = arr;
    [self setNeedsDisplay];
}

- (void)setMaxY:(CGFloat)maxY {
    _yMax = maxY;
}

- (void)drawLine {
    CGFloat hY = _height - 20;
    CGFloat gap = 10;
    CGFloat w = _gapW;
    
    CGFloat x,y;
    x = 0;
    if (_yMax == 0) {
        y = hY +gap;
    } else {
        y = hY * (1- ([_arr[0] floatValue] - _yMin)/(_yMax - _yMin)) +gap;
    }
    
    UIBezierPath *lineGraph = [UIBezierPath bezierPath];
    lineGraph.lineCapStyle = kCGLineCapRound;
    lineGraph.lineJoinStyle = kCGLineJoinRound;
    lineGraph.lineWidth = BEZIER_PATH_WIDTH; // line width
    [lineGraph moveToPoint:CGPointMake(x, y)];
    
    CGFloat tempx = x,tempy = y;
    
    for(int i = 0; i < _arr.count;i++) {
        x = w * i;
        if (_yMax == 0) {
            y = hY +gap ;
        } else {
            y = hY * (1- ([_arr[i] floatValue] - _yMin)/(_yMax - _yMin)) + gap;
        }
        NSLog(@"======>>>> %f:%f",x,y);
        if (i > 0) {
            /*折线*/
            [lineGraph addLineToPoint:CGPointMake(x, y)];
            /*平缓曲线*/
//            [lineGraph addCurveToPoint:CGPointMake(x, y) controlPoint1:CGPointMake((x - tempx) / 2 + tempx, tempy) controlPoint2:CGPointMake((x-tempx)/2+tempx, y)];
        }
        CoinLabel *coin = [[CoinLabel alloc] initWithFrame:CGRectMake(x-3, y-3, 6, 6)];
        [coin setStrokeColor:_coinColor];
        [coin setFillColor:_coinColor];
        [self addSubview:coin];
        tempx = x;
        tempy = y;
    
    }
    [_lineColor setStroke];
    [lineGraph stroke];
}

- (void)drawRect:(CGRect)rect {
    [self drawLine];
}

@end



@implementation CoinLabel
{
    UIColor *_strokeColor;
    UIColor *_fillColor;
}

- (void)setStrokeColor:(UIColor *)color {
    _strokeColor = color;
}

- (void)setFillColor:(UIColor *)color {
    _fillColor = color;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    [self setClearsContextBeforeDrawing: YES];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = width / 2;
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:width *0.5];
    // 创建一个shapeLayer
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.frame         = self.bounds;                // 与showView的frame一致
    if (_strokeColor) {
        layer2.strokeColor = _strokeColor.CGColor;   // 边缘线的颜色
        layer2.lineWidth = 2.0f;                           // 线条宽度
    }
    
    layer2.fillColor = [UIColor whiteColor].CGColor;   // 闭环填充的颜色
    if (_fillColor) {
        layer2.fillColor = _fillColor.CGColor;   // 闭环填充的颜色
    }
    layer2.path          = path2.CGPath;                    // 从贝塞尔曲线获取到形状
    layer2.strokeStart   = 0.0f;
    layer2.strokeEnd     = 1.0f;
    [self.layer addSublayer:layer2];
}

@end
