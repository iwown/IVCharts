//
//  IVRateLine.m
//  IVCharts
//
//  Created by A$CE on 2019/6/18.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "IVRateLine.h"

@interface IVRateLine()
{
    NSMutableArray  *_arr;
}
@end


@implementation IVRateLine

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        _arr = [NSMutableArray arrayWithCapacity:0];
        [self initParam];
    }
    return self;
}

- (void)initParam {
    _lineColor = [UIColor greenColor];
    _xTimeMax = 144;
    _bpmMax = 200;
    _dot_distance = 1;
}

- (void)setDataSource:(NSArray *)arr {
    [_arr removeAllObjects];
    [_arr addObjectsFromArray:arr];
}

- (void)reload {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_arr.count != 0) {
        if (_dashLineNumber > 0) {
            [self drawHorizontalLines:context];
        }
        [self drawHrLine:context];
    }
}

- (void)drawHorizontalLines:(CGContextRef)context {
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0xcd/255.0, 0xcd/255.0, 0xcd/255.0, 0.5);
    CGFloat lengths[] = {2,5};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGFloat unitHeight = self.frame.size.height/_dashLineNumber;
    for (int i = 0; i < _dashLineNumber+1; i++) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, 0,0 + i*unitHeight*1);//移动到指定位置（设置路径起点）
        CGPathAddLineToPoint(path, nil, self.frame.size.width, 0 + i*unitHeight);
        CGContextAddPath(context, path);
        CFRelease(path);
        if (_bottomFullLine && i == _dashLineNumber) {
            CGContextSetRGBStrokeColor(context, 0xFF/255.0, 0xFF/255.0, 0xFF/255.0, 1);
            CGContextSetLineDash(context, 0, lengths,0);
        }
        CGContextStrokePath(context);
    }
}

- (void)drawHrLine:(CGContextRef)context {
    CGFloat scale = self.frame.size.width/_xTimeMax;//x坐标比例
    CGFloat hr_scale = self.frame.size.height/_bpmMax;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    CGPoint tempP;
    for (int i = 0; i<[_arr count]; i++) {
        CGPoint p = [_arr[i] CGPointValue];
        if (i == 0) {
            [linePath moveToPoint:CGPointMake(p.x*scale, (_bpmMax - p.y)*hr_scale)];
            [linePath addLineToPoint:CGPointMake(p.x*scale, (_bpmMax - p.y)*hr_scale)];
        } else {
            if (p.x == tempP.x+_dot_distance) {
                //连续的
                [linePath addLineToPoint:CGPointMake(p.x*scale, (_bpmMax - p.y)*hr_scale)];
            } else {
                //非连续的
                [linePath moveToPoint:CGPointMake(p.x*scale, (_bpmMax - p.y)*hr_scale)];
                [linePath addLineToPoint:CGPointMake(p.x*scale, (_bpmMax - p.y)*hr_scale)];
            }
        }
        tempP = p;
    }
    
    [linePath setLineWidth:1.5];    
    [linePath setLineJoinStyle:kCGLineJoinRound];
    [linePath setLineCapStyle:kCGLineCapRound];
    CGFloat lengths[] = {2,0};
    [linePath setLineDash:lengths count:2 phase:0];
    if (_lineColor) {
        [_lineColor set];
    } else {
        [[UIColor whiteColor] set];
    }
    [linePath stroke];
}

@end
