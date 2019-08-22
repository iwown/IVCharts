//
//  IVCoinLine.h
//  linyi
//
//  Created by west on 2017/8/22.
//  Copyright © 2017年 com.kunekt.healthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVCoinLine : UIView

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIColor *coinColor;

@property (nonatomic, strong) NSArray *arr;

- (instancetype)initWithFrame:(CGRect)frame gapW:(CGFloat)gapW maxY:(CGFloat)maxY;
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
