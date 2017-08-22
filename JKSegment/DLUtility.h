//
//  DLUtility.h
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DLUtility : NSObject
+ (UIColor *)getColorOfPercent:(CGFloat)percent between:(UIColor *)color1 and:(UIColor *)color2;
+ (UIFont *)getFontOfPercent:(CGFloat)percent between:(UIFont *)font1 and:(UIFont*)font2;
@end
