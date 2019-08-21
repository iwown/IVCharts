//
//  IVCoinLine.h
//  linyi
//
//  Created by west on 2017/8/22.
//  Copyright © 2017年 com.kunekt.healthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVCoinLine : UIView
{
    CGFloat         _width;
    CGFloat         _height;
    CGFloat         _yMin;
    CGFloat         _yMax;
    CGFloat         _gapW;
    CGFloat         _gapH;
    CGFloat         _target;
    NSArray         *_arr;
    
    UIColor         *_lineColor;
    UIColor         *_pointColor;
    UIColor         *_pointFillColor;
    UIColor         *_pointStrokeColor;
}

@property (nonatomic) NSArray *arr;

- (instancetype)initWithFrame:(CGRect)frame gapW:(CGFloat)gapW;
- (void)setArr:(NSArray *)arr;
- (void)setMaxY:(CGFloat)maxY;
- (void)drawLine;
- (NSInteger)yMax;
- (NSInteger)yMin;

@end


@interface CoinLabel : UILabel
- (void)setStrokeColor:(UIColor *)color;
- (void)setFillColor:(UIColor *)color;
@end
