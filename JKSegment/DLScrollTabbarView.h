//
//  DLScrollTabbarView.h
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSlideTabbarProtocol.h"

@interface DLScrollTabbarItem : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subTitle;
@property(nonatomic, assign) CGFloat width;
+ (DLScrollTabbarItem *)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle width:(CGFloat)width;
@end

@interface DLScrollTabbarView : UIView<DLSlideTabbarProtocol>
@property(nonatomic, strong) UIView *backgroundView;

// tabbar属性
@property (nonatomic, strong) UIColor *tabItemNormalColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *tabItemSelectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont * tabItemNormalFont;
@property(nonatomic, strong) UIColor *trackColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImageView *trackView;
@property(nonatomic,assign) CGFloat trackViewHeight;
@property(nonatomic,assign) CGFloat trackViewBottom;
@property(nonatomic, strong) NSArray *tabbarItems;

/// 自定义部分字体 font color
@property (nonatomic, strong) UIColor *tabItemCustomColor;
@property (nonatomic, strong) UIColor *tabItemCustomSelectColor;
@property (nonatomic, strong) UIFont  *tabItemCustomFont;
@property (nonatomic, strong) UIFont  *tabItemCustomSelectFont;

/// 控制 线的等宽，默认为不等宽 NO
@property (nonatomic) BOOL isLineEquelWidth;
//  控制线的宽度 一定。
@property (assign, nonatomic) CGFloat constWidth;

// DLSlideTabbarProtocol
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<DLSlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;
- (void)updateTitleWithItem:(DLScrollTabbarItem *)item index:(NSInteger)index;

@end

