//
//  ConstAndStruct.h
//  IVCharts
//
//  Created by A$CE on 2019/4/2.
//  Copyright © 2019年 Iwown. All rights reserved.
//

#ifndef ConstAndStruct_h
#define ConstAndStruct_h

#import <UIKit/UIKit.h>
//屏幕宽度
#define IVC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define IVC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

typedef struct {
    float red;
    float green;
    float blue;
    float alpha;
} IVSColor;

#endif /* ConstAndStruct_h */
