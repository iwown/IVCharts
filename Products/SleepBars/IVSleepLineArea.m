//
//  IVSleepLineArea.m
//  IVCharts
//
//  Created by A$CE on 2019/12/24.
//  Copyright © 2019 Iwown. All rights reserved.
//
#import "GGSBSleep.h"
#import "ConstAndStruct.h"
#import "IVSleepLineArea.h"

@implementation IVSleepLineArea {
    UIView *horizonLine;
    CGFloat _sb_width;
    CGFloat _sb_height;
    CGFloat _gap_margin;
}

- (void)reload {
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _sb_width = frame.size.width;
        _sb_height = frame.size.height;
        _gap_margin = 28;
        _textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor redColor];
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
    [[self.layer.sublayers copy] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self drawColumnData];
}

- (void)drawColumnData {
    //画 x 轴
    horizonLine=[UIView new];
    horizonLine.backgroundColor=_textColor;
    horizonLine.frame = CGRectMake(_gap_margin, _sb_height - _gap_margin, _sb_width - (_gap_margin * 2), 1);
    [self addSubview:horizonLine];
    
    //画刻度
    UILabel* startLab=[UILabel new];
    startLab.font=[UIFont systemFontOfSize:12];
    startLab.textColor=_textColor;
    startLab.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)_sleepModel.start_time.hour,(long)_sleepModel.start_time.minute];
    
    [startLab setFrame:CGRectMake(horizonLine.frame.origin.x, _sb_height - _gap_margin + 2, horizonLine.frame.size.width, 12)];
    [startLab sizeToFit];
    [self addSubview:startLab];
    
    UILabel* endLab=[UILabel new];
    endLab.font=[UIFont systemFontOfSize:12];
    endLab.textColor=_textColor;
    endLab.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)_sleepModel.end_time.hour,(long)_sleepModel.end_time.minute];
    [endLab sizeToFit];
    [endLab setFrame:CGRectMake(_sb_width - 40, _sb_height - _gap_margin + 2, horizonLine.frame.size.width, 12)];
    [self addSubview:endLab];
    
    GGSB_Date startDate=_sleepModel.start_time;
    GGSB_Date endDate=_sleepModel.end_time;
    NSInteger durationHour=endDate.hour-startDate.hour;
    if (durationHour<0) {
        durationHour+=24;
    }
    
    NSInteger start = startDate.minute + 60 *startDate.hour;
    NSInteger end = endDate.minute + 60 *endDate.hour;
    NSInteger duation = end - start;
    if (duation < 0) {
        duation = duation + 1440;
    }
    CGFloat length_unit = (float)(_sb_width - 28*2)/duation;
    
    //画第一个刻度
    UIView *first = [UIView new];
    first.backgroundColor = _textColor;
    CGFloat xF = _gap_margin + length_unit * (60-startDate.minute);
    first.frame = CGRectMake(xF, _sb_height - _gap_margin-2, 1, 2);
    [self addSubview:first];
    
    for (int i=1; i<durationHour; ++i) {
        UIView* tmp=[UIView new];
        tmp.backgroundColor=[UIColor whiteColor];
        CGFloat x = (xF + 1) + length_unit * (60*i);
        tmp.frame = CGRectMake(x, _sb_height - _gap_margin-2, 1, 2);
        [self addSubview:tmp];
    }
    
    //画纵轴
    if (_sleepModel.segment.count < 2) {
        NSLog(@"数据太少，画不出来");
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 3);
    int preSleepType = INT_MAX;
    CGPoint prePoint = CGPointMake(_gap_margin, _sb_height - _gap_margin - 140);
    UIColor *preColor = [UIColor whiteColor];
    for (int i = 0; i < _sleepModel.segment.count; i++) {
        GGSBItem *item = _sleepModel.segment[i];
        NSInteger theSleepType = item.type;
        NSInteger startTime = item.st;
        NSInteger endTime = item.et;
        NSInteger activity = endTime - startTime;
        
        NSInteger nextSleepType = 2;
        if (i < _sleepModel.segment.count-1) {
            nextSleepType = [_sleepModel.segment[i+1] type];
        }
        
        CGFloat x = startTime;
        
        UIColor *tmpColor;
        CGFloat xS = _gap_margin + (x-start) * length_unit;
        CGFloat wS = activity * length_unit;
        CGFloat hS = 0;
        if (theSleepType == 3) {
            hS=20;
            tmpColor=[UIColor colorWithRed:0x2b/255.0 green:0x0f/255.0 blue:0x53/255.0 alpha:1];
        }
        else if (theSleepType == 4) {
            hS=60;
            tmpColor=[UIColor colorWithRed:0xb4/255.0 green:0x81/255.0 blue:0xff/255.0 alpha:1];
        }
        else if (theSleepType == 6) {
            hS=100;
            tmpColor=[UIColor colorWithRed:0xff/255.0 green:0xba/255.0 blue:0x4a/255.0 alpha:1];
        }else if (theSleepType == 7) {
            hS=140;
            tmpColor=[UIColor colorWithRed:0x9f/255.0 green:0x0a/255.0 blue:0x01/255.0 alpha:1];
        }else {
            continue;
        }
        
        UIRectCorner rectCorner = 0;
        if (theSleepType < preSleepType) {
            rectCorner = UIRectCornerBottomLeft;
        }else {
            rectCorner = UIRectCornerTopLeft;
        }
        if (theSleepType < nextSleepType) {
            rectCorner |= UIRectCornerBottomRight;
        }else {
            rectCorner |= UIRectCornerTopRight;
        }
        preSleepType = (int)theSleepType;
        CGFloat yS = _sb_height - _gap_margin - hS;
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineJoinStyle = kCGLineJoinRound;
        CGFloat rHeight = 16;
        /*方案一: 通过曲线画图，线的显示更自然，优雅。
         radious参数用于调整圆角显示效果。
        CGFloat radious = 3;
        [path moveToPoint:CGPointMake(xS, yS)];
        if (rectCorner == (UIRectCornerBottomLeft|UIRectCornerBottomRight)) {
            [path addQuadCurveToPoint:CGPointMake(xS+wS, yS) controlPoint:CGPointMake(xS+wS/2, yS+radious)];
            [path addLineToPoint:CGPointMake(xS+wS, yS+rHeight-radious)];
            [path addCurveToPoint:CGPointMake(xS, yS+rHeight-radious) controlPoint1:CGPointMake(xS+wS-radious, yS+rHeight) controlPoint2:CGPointMake(xS+radious, yS+rHeight)];
            [path closePath];
        }else if (rectCorner == (UIRectCornerTopLeft|UIRectCornerTopRight)) {
            [path addCurveToPoint:CGPointMake(xS+wS, yS) controlPoint1:CGPointMake(xS+radious, yS-radious) controlPoint2:CGPointMake(xS+wS-radious, yS-radious)];
            [path addLineToPoint:CGPointMake(xS + wS, yS+rHeight)];
            [path addQuadCurveToPoint:CGPointMake(xS, yS+rHeight) controlPoint:CGPointMake(xS + wS/2, yS+rHeight-radious)];
            [path closePath];
        }else if (rectCorner == (UIRectCornerBottomLeft|UIRectCornerTopRight)){
            [path addCurveToPoint:CGPointMake(xS+wS, yS+radious) controlPoint1:CGPointMake(xS+radious, yS+radious/2) controlPoint2:CGPointMake(xS+wS-radious, yS+radious/2)];
            [path addLineToPoint:CGPointMake(xS+wS, yS+rHeight)];
            [path addCurveToPoint:CGPointMake(xS, yS+rHeight-radious) controlPoint1:CGPointMake(xS+wS-radious, yS+rHeight-radious/2) controlPoint2:CGPointMake(xS+radious, yS+rHeight-radious/2)];
            [path closePath];
        }else if (rectCorner == (UIRectCornerTopLeft|UIRectCornerBottomRight)){
            [path addCurveToPoint:CGPointMake(xS+wS, yS-radious) controlPoint1:CGPointMake(xS+radious, yS-radious/2) controlPoint2:CGPointMake(xS+wS-radious, yS-radious/2)];
            [path addLineToPoint:CGPointMake(xS+wS, yS+rHeight)];
            [path addCurveToPoint:CGPointMake(xS, yS+rHeight+radious) controlPoint1:CGPointMake(xS+wS-radious, yS+rHeight+radious/2) controlPoint2:CGPointMake(xS+radious, yS+rHeight+radious/2)];
            [path closePath];
        }
        */
        /*方案一: 通过矩阵的圆角达成效果，角的显示效果更好
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xS, yS, wS, 18) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
        */
        [tmpColor setFill];
        [path fill];
        [tmpColor setStroke];
        [path stroke];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)preColor.CGColor, (__bridge id)tmpColor.CGColor];
        CGFloat top, bottom;
        CGFloat ysCenter = yS+rHeight*0.5;
        BOOL isLeft = NO;
        if (prePoint.y>ysCenter) {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(0, 0);
            gradientLayer.frame = CGRectMake(xS-0.55, ysCenter, 1, fabs(ysCenter-prePoint.y));
            top = ysCenter;
            bottom = prePoint.y;
            isLeft = NO;
        }else {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            gradientLayer.frame = CGRectMake(xS-0.5, prePoint.y, 1, fabs(ysCenter-prePoint.y));
            top = prePoint.y;
            bottom = ysCenter;
            isLeft = YES;
        }
        gradientLayer.cornerRadius = 0.5;
        [self.layer addSublayer:gradientLayer];
        
        prePoint = CGPointMake(xS + wS, yS + 9);
        preColor = tmpColor;
    }
}

- (CAShapeLayer *)generateShapeLayerWithLineWidth {
    CAShapeLayer *waveline = [CAShapeLayer layer];
    waveline.lineCap = kCALineCapButt;
    waveline.lineJoin = kCALineJoinRound;
    waveline.lineWidth = 1;
    return waveline;
}

- (UIBezierPath *)generateBezierPathWithTop:(CGPoint)top andBottom:(CGPoint)bottom leftOrRight:(BOOL)left {
    CGFloat corRadius = 5;
    if (left) {
        corRadius = -5;
    }
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    circlePath.lineJoinStyle = kCGLineJoinRound;
    [circlePath moveToPoint:top];
    [circlePath addLineToPoint:CGPointMake(top.x + corRadius, top.y + corRadius)];
    [circlePath addQuadCurveToPoint:bottom controlPoint:CGPointMake(top.x, top.y + corRadius * 2)];
    [circlePath addLineToPoint:CGPointMake(bottom.x - corRadius, bottom.y - corRadius)];
    [circlePath addQuadCurveToPoint:top controlPoint:CGPointMake(bottom.x, bottom.y - corRadius * 2)];
    return circlePath;
}

@end
