//
//  DLUtility.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import "DLUtility.h"

@implementation DLUtility
+ (UIColor *)getColorOfPercent:(CGFloat)percent between:(UIColor *)color1 and:(UIColor *)color2{
    CGFloat red1, green1, blue1, alpha1;
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    
    CGFloat red2, green2, blue2, alpha2;
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    CGFloat p1 = percent;
    CGFloat p2 = 1.0 - percent;
    UIColor *mid = [UIColor colorWithRed:red1*p1+red2*p2 green:green1*p1+green2*p2 blue:blue1*p1+blue2*p2 alpha:1.0f];
    return mid;
}

+ (UIFont *)getFontOfPercent:(CGFloat)percent between:(UIFont *)font1 and:(UIFont*)font2{
    
    if (percent > 0.5) {
        return font2;
    } else {
        return font1;
    }
    
//    CGFloat f1 = font1.pointSize;
//    CGFloat f2 = font2.pointSize;
//    CGFloat fontSize = f1 + (f2 - f1)*percent;
//
//    if (percent > 0.5) {
//        return [font2 fontWithSize:fontSize];
//    } else {
//        return [font1 fontWithSize:fontSize];
//    }
}


@end
