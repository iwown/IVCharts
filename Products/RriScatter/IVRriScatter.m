//
//  IVRriScatter.m
//  IVCharts
//
//  Created by A$CE on 2019/3/28.
//  Copyright © 2019年 Iwown. All rights reserved.
//

#import "IVRriScatter.h"

@interface IVRriScatter() {
    CGFloat _gapScale;
}

@end

@implementation IVRriScatter

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _gapScale = frame.size.width * 0.2;
        IVSColor scColor = {1, 1, 1, 1};
        self.pointColor = scColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    if (!self.baseColor) {
        self.baseColor = [UIColor clearColor];
    }
    [self.baseColor setFill];
    UIRectFill(rect);
    [self addLeftLabel];
    [self addBottomLabel];
    [self drawHorizontalLines:context];
    [self drawVerticalLines:context];
    [self addPoints:context];
}

- (void)addPoints:(CGContextRef)context {
    CGFloat totalLength = self.frame.size.height;
    CGFloat chartLength = totalLength - _gapScale;
    CGFloat hrGap = chartLength / 2000.0;

    CGFloat leftWidth = _gapScale * 0.7;
    CGFloat bottomHeight = _gapScale * 0.7;
    
    CGFloat x0 = leftWidth;
    CGFloat y0 = totalLength - bottomHeight;
    //设置填充颜色
    CGContextSetRGBFillColor (context, self.pointColor.red, self.pointColor.green, self.pointColor.blue, self.pointColor.alpha);
    for (NSValue *value in self.dataSource) {
        CGPoint point = value.CGPointValue;
        CGFloat x = x0 + point.x * hrGap;
        CGFloat y = y0 - point.y * hrGap;
        //添加一个圆
        CGContextAddArc(context, x, y, 2, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathFill);
    }
}

- (void)addLeftLabel {
    CGFloat unitHeight = _gapScale;
    CGFloat leftWidth = _gapScale * 0.7;
    CGFloat topHeight = _gapScale * 0.3;
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWidth, 10)];
        CGFloat hetight = topHeight + i*unitHeight;
        [label setCenter:CGPointMake(leftWidth/2.0, hetight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = [NSString stringWithFormat:@"%ld",(long)(4-i)*500];
        label.textColor = [UIColor colorWithRed:0xaf/255.0 green:0xaf/255.0 blue:0xaf/255.0 alpha:0.5];
        [self addSubview:label];
    }
}

- (void)addBottomLabel {
    CGFloat unitWidth = _gapScale;
    CGFloat leftWidth = _gapScale * 0.7;
    CGFloat bottomHeight = _gapScale * 0.7;
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftWidth, bottomHeight)];
        CGFloat hetight = self.frame.size.height - (bottomHeight * 0.5);
        CGFloat lWidth = leftWidth + i * unitWidth;
        [label setCenter:CGPointMake(lWidth , hetight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.text = [NSString stringWithFormat:@"%ld",(long)i*500];
        label.textColor = [UIColor colorWithRed:0xaf/255.0 green:0xaf/255.0 blue:0xaf/255.0 alpha:0.5];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
    }
}

- (void)drawHorizontalLines:(CGContextRef)context {
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0xaf/255.0, 0xaf/255.0, 0xaf/255.0, 0.5);
    CGFloat lengths[] = {5,4};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGFloat unitHeight = _gapScale;
    CGFloat leftWidth = _gapScale * 0.7;
    CGFloat topHeight = _gapScale * 0.3;
    CGFloat rightWidth = _gapScale * 0.3;
    for (int i = 0; i < 5; i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        //移动到指定位置（设置路径起点）
        CGPathMoveToPoint(path, nil, leftWidth, topHeight + i*unitHeight);
        CGPathAddLineToPoint(path, nil, self.frame.size.width-rightWidth, topHeight + i*unitHeight);
        CGContextAddPath(context, path);
        CFRelease(path);
        CGContextStrokePath(context);
    }
}

- (void)drawVerticalLines:(CGContextRef)context {
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0xaf/255.0, 0xaf/255.0, 0xaf/255.0, 0.5);
    CGFloat lengths[] = {5,4};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGFloat unitHeight = _gapScale;
    CGFloat leftWidth = _gapScale * 0.7;
    CGFloat topHeight = _gapScale * 0.3;
    CGFloat bottomHeight = _gapScale * 0.7;
    for (int i = 0; i < 5; i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, leftWidth + i*unitHeight, topHeight);
        CGPathAddLineToPoint(path, nil, leftWidth + i*unitHeight, self.frame.size.height - bottomHeight);
        CGContextAddPath(context, path);
        CFRelease(path);
        CGContextStrokePath(context);
    }
}

@end
