//
//  DLScrollTabbarView.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 15-2-12.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import "DLScrollTabbarView.h"
#import "DLUtility.h"


#define kTrackViewHeight 1
#define kImageSpacingX 3.0f

#define kLabelTagBase 1000
#define kImageTagBase 2000
#define kSelectedImageTagBase 3000
#define kViewTagBase 4000

@implementation DLScrollTabbarItem
+ (DLScrollTabbarItem *)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle width:(CGFloat)width{
    DLScrollTabbarItem *item = [[DLScrollTabbarItem alloc] init];
    item.title    = title;
    item.subTitle = subTitle;
    item.width    = width;
    return item;
}
@end


@implementation DLScrollTabbarView{
    UIScrollView *scrollView_;
    UIImageView *trackView_;
}

- (void)commonInit{
    _selectedIndex = -1;
    self.isLineEquelWidth = NO;
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView_.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView_];
    
    trackView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-kTrackViewHeight-1, self.bounds.size.width, kTrackViewHeight)];
    [scrollView_ addSubview:trackView_];
    trackView_.layer.cornerRadius = 2.0f;
    
}

-(void)setTrackViewHeight:(CGFloat )trackViewHeight{
    _trackViewHeight = trackViewHeight;

    trackView_.frame = CGRectMake(trackView_.frame.origin.x, trackView_.frame.origin.y, trackView_.frame.size.width, trackViewHeight);
    
}
-(void)setTrackViewBottom:(CGFloat)trackViewBottom{
    _trackViewBottom = trackViewBottom;
    
    CGFloat bottom = self.bounds.size.height - kTrackViewHeight-trackViewBottom;
    CGRect frame = trackView_.frame;
    frame.origin.y = bottom - frame.size.height;
    trackView_.frame = frame;

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)setBackgroundView:(UIView *)backgroundView{
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        [self insertSubview:backgroundView atIndex:0];
        _backgroundView = backgroundView;
    }
}

- (void)setTabItemNormalColor:(UIColor *)tabItemNormalColor{
    _tabItemNormalColor = tabItemNormalColor;
    
    for (int i=0; i<[self tabbarCount]; i++) {
        if (i == self.selectedIndex) {
            continue;
        }
        UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+i];
        label.textColor = tabItemNormalColor;
    }
}

- (void)setTabItemSelectedColor:(UIColor *)tabItemSelectedColor{
    _tabItemSelectedColor = tabItemSelectedColor;
    
    UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+self.selectedIndex];
    label.textColor = tabItemSelectedColor;
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    trackView_.backgroundColor = trackColor;
}

- (void)setTabbarItems:(NSArray *)tabbarItems{
    if (_tabbarItems != tabbarItems) {
        _tabbarItems = tabbarItems;

        float height = self.bounds.size.height;
        float x = 0.0f;
        NSInteger i=0;
        for (DLScrollTabbarItem *item in tabbarItems) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, item.width, height)];
            backView.backgroundColor = [UIColor clearColor];
            backView.tag = kViewTagBase + i;
            
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
            NSRange range = [item.title rangeOfString:item.subTitle];
            if (range.location != NSNotFound) {
                [attStr addAttribute:NSForegroundColorAttributeName value:self.tabItemCustomColor range:NSMakeRange(range.location, range.length)];
                [attStr addAttribute:NSFontAttributeName value:self.tabItemCustomFont range:NSMakeRange(range.location, range.length)];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, item.width, height)];
            label.font = self.tabItemNormalFont;
            label.backgroundColor = [UIColor clearColor];
            label.textColor = self.tabItemNormalColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText  = attStr;
            
            CGSize size = [item.title sizeWithAttributes:@{NSFontAttributeName:self.tabItemNormalFont}];
            CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
            
            CGRect frame = label.frame;
            frame.size.width = statuseStrSize.width;
            label.frame = frame;

            
            
      
            label.tag = kLabelTagBase+i;

            label.frame = CGRectMake((item.width-label.bounds.size.width)/2.0f, (height-label.bounds.size.height)/2.0f, CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
            [backView addSubview:label];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [backView addGestureRecognizer:tap];

            [scrollView_ addSubview:backView];
            x += item.width;
            i++;
        }
        scrollView_.contentSize = CGSizeMake(x, height);

        [self layoutTabbar];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    scrollView_.frame = self.bounds;
    [self layoutTabbar];
}

- (void)layoutTabbar{
//    float width = self.bounds.size.width/self.tabbarItems.count;
//    float height = self.bounds.size.height;
//    float x = 0.0f;
//    for (NSInteger i=0; i<self.tabbarItems.count; i++) {
//        x = i*width;
//        UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+i];
//        UIImageView *imageView = (UIImageView *)[scrollView_ viewWithTag:kImageTagBase+i];
//        UIImageView *selectedIamgeView = (UIImageView *)[scrollView_ viewWithTag:kSelectedImageTagBase+i];
//        label.frame = CGRectMake(x + (width-label.bounds.size.width-CGRectGetWidth(imageView.bounds))/2.0f, (height-label.bounds.size.height)/2.0f, CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
//        imageView.frame = CGRectMake(label.frame.origin.x + label.bounds.size.width+kImageSpacingX, (height-imageView.bounds.size.height)/2.0, CGRectGetWidth(imageView.bounds), CGRectGetHeight(imageView.bounds));
//        selectedIamgeView.frame = imageView.frame;
//    }
    
//    float trackX = width*self.selectedIndex;
//    trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, width, kTrackViewHeight);
}

- (NSInteger)tabbarCount{
    return self.tabbarItems.count;
}

- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent{
    //DLScrollTabbarItem *fromItem = [self.tabbarItems objectAtIndex:fromIndex];
    if (self.isLineEquelWidth) {
        CGFloat x = fromIndex * [[self.tabbarItems firstObject] width] + [[self.tabbarItems firstObject] width] * percent * (toIndex - fromIndex);
        trackView_.frame = CGRectMake(x, trackView_.frame.origin.y, [[self.tabbarItems firstObject] width], CGRectGetHeight(trackView_.bounds));
    }else{
        UILabel *fromLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+fromIndex];
        fromLabel.textColor = [DLUtility getColorOfPercent:percent between:self.tabItemNormalColor and:self.tabItemSelectedColor];
        
        DLScrollTabbarItem *fromItem = self.tabbarItems[fromIndex];
        UIColor *fromColor = [DLUtility getColorOfPercent:percent between:self.tabItemCustomColor and:self.tabItemCustomSelectColor];
        UIFont *fromFont   = [DLUtility getFontOfPercent:percent between:self.tabItemCustomSelectFont and:self.tabItemCustomFont];
        NSMutableAttributedString *fromAttStr = [[NSMutableAttributedString alloc]initWithString:fromItem.title];
        NSRange range = [fromItem.title rangeOfString:fromItem.subTitle];
        if (range.location != NSNotFound) {
            
            [fromAttStr addAttribute:NSForegroundColorAttributeName value:fromColor range:NSMakeRange(range.location, range.length)];
            [fromAttStr addAttribute:NSFontAttributeName value:fromFont range:NSMakeRange(range.location, range.length)];
        }
        
        fromLabel.attributedText = fromAttStr;
        
        UILabel *toLabel = nil;
        if (toIndex >= 0 && toIndex < [self tabbarCount]) {
            //DLScrollTabbarItem *toItem = [self.tabbarItems objectAtIndex:toIndex];
            toLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+toIndex];
            toLabel.textColor = [DLUtility getColorOfPercent:percent between:self.tabItemSelectedColor and:self.tabItemNormalColor];
            
            DLScrollTabbarItem *item = self.tabbarItems[toIndex];
            UIColor *toColor = [DLUtility getColorOfPercent:percent between:self.tabItemCustomSelectColor and:self.tabItemCustomColor];
            UIFont *toFont   = [DLUtility getFontOfPercent:percent between:self.tabItemCustomFont and:self.tabItemCustomSelectFont];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
            NSRange range = [item.title rangeOfString:item.subTitle];
            
            if (range.location != NSNotFound) {
                [attStr addAttribute:NSForegroundColorAttributeName value:toColor range:NSMakeRange(range.location, range.length)];
                [attStr addAttribute:NSFontAttributeName value:toFont range:NSMakeRange(range.location, range.length)];
            }
            
            toLabel.attributedText = attStr;
        }
        
        // 计算track view位置和宽度
        CGRect fromRc = [scrollView_ convertRect:fromLabel.bounds fromView:fromLabel];
        CGFloat fromWidth = fromLabel.frame.size.width;
        CGFloat fromX = fromRc.origin.x;
        CGFloat toX;
        CGFloat toWidth;
        if (toLabel) {
            CGRect toRc = [scrollView_ convertRect:toLabel.bounds fromView:toLabel];
            toWidth = toRc.size.width;
            toX = toRc.origin.x;
        }
        else{
            toWidth = fromWidth;
            if (toIndex > fromIndex) {
                toX = fromX + fromWidth;
            }
            else{
                toX = fromX - fromWidth;
            }
        }
        
        CGFloat width = toWidth * percent + fromWidth*(1-percent);
        
        CGFloat x = fromX + (toX - fromX)*percent;
        
        trackView_.frame = CGRectMake(x, trackView_.frame.origin.y, width, CGRectGetHeight(trackView_.bounds));
    }
    
    


    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex != selectedIndex) {
        if (_selectedIndex >= 0) {
            //DLScrollTabbarItem *fromItem = [self.tabbarItems objectAtIndex:_selectedIndex];
            UILabel *fromLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+_selectedIndex];
            fromLabel.textColor = self.tabItemNormalColor;
            
            DLScrollTabbarItem *item = self.tabbarItems[_selectedIndex];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
            NSRange range = [item.title rangeOfString:item.subTitle];
            
            if (range.location != NSNotFound) {
                [attStr addAttribute:NSForegroundColorAttributeName value:self.tabItemCustomColor range:NSMakeRange(range.location, range.length)];
                [attStr addAttribute:NSFontAttributeName value:self.tabItemCustomFont range:NSMakeRange(range.location, range.length)];
            }
            
            fromLabel.attributedText = attStr;
        }
        
        if (selectedIndex >= 0 && selectedIndex < [self tabbarCount]) {
            //DLScrollTabbarItem *toItem = [self.tabbarItems objectAtIndex:selectedIndex];
            UILabel *toLabel = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+selectedIndex];
            toLabel.textColor = self.tabItemSelectedColor;
            
            DLScrollTabbarItem *item = self.tabbarItems[selectedIndex];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
            NSRange range = [item.title rangeOfString:item.subTitle];
            
            if (range.location != NSNotFound) {
                
                [attStr addAttribute:NSForegroundColorAttributeName value:self.tabItemCustomSelectColor range:NSMakeRange(range.location, range.length)];
                [attStr addAttribute:NSFontAttributeName value:self.tabItemCustomSelectFont range:NSMakeRange(range.location, range.length)];
            }
            
            toLabel.attributedText = attStr;
            
            UIView *selectedView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex];
            //CGRect selectedRect = selectedView.frame;
            CGRect rc = selectedView.frame;
            //选中的居中显示
            rc = CGRectMake(CGRectGetMidX(rc) - scrollView_.bounds.size.width/2.0f, rc.origin.y, scrollView_.bounds.size.width, rc.size.height);
// 滚动左右两格到可见位置
//            if (selectedIndex > 0) {
//                UIView *leftView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex-1];
//                rc = CGRectUnion(rc, leftView.frame);
//            }
//            if (selectedIndex < [self tabbarCount]-1) {
//                UIView *rightView = [scrollView_ viewWithTag:kViewTagBase+selectedIndex+1];
//                rc = CGRectUnion(rc, rightView.frame);
//            }
            [scrollView_ scrollRectToVisible:rc animated:YES];
            
            // track view
            if (self.isLineEquelWidth) {
                 trackView_.frame = CGRectMake([[self.tabbarItems firstObject] width] * selectedIndex, trackView_.frame.origin.y, [[self.tabbarItems firstObject] width], CGRectGetHeight(trackView_.bounds));
            }else{
                CGRect trackRc = [scrollView_ convertRect:toLabel.bounds fromView:toLabel];
                trackView_.frame = CGRectMake(trackRc.origin.x, trackView_.frame.origin.y, trackRc.size.width, CGRectGetHeight(trackView_.bounds));
            }


        }
        
//        float width = self.bounds.size.width/self.tabbarItems.count;
//        float trackX = width*selectedIndex;
//        trackView_.frame = CGRectMake(trackX, trackView_.frame.origin.y, CGRectGetWidth(trackView_.bounds), CGRectGetHeight(trackView_.bounds));
        
        _selectedIndex = selectedIndex;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSInteger i = tap.view.tag - kViewTagBase;
    self.selectedIndex = i;
    if (self.delegate) {
        [self.delegate DLSlideTabbar:self selectAt:i];
    }
}

- (void)updateTitleWithItem:(DLScrollTabbarItem *)item index:(NSInteger)index{
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.tabbarItems];
    [arr replaceObjectAtIndex:index withObject:item];
    _tabbarItems = arr;
    
    UILabel *label = (UILabel *)[scrollView_ viewWithTag:kLabelTagBase+index];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSRange range = [item.title rangeOfString:item.subTitle];
    
    if (range.location != NSNotFound) {
        if (self.selectedIndex == index) {
            [attStr addAttribute:NSForegroundColorAttributeName value:self.tabItemCustomSelectColor range:NSMakeRange(range.location, range.length)];
            [attStr addAttribute:NSFontAttributeName value:self.tabItemCustomSelectFont range:NSMakeRange(range.location, range.length)];
        }else{
            [attStr addAttribute:NSForegroundColorAttributeName value:self.tabItemCustomColor range:NSMakeRange(range.location, range.length)];
            [attStr addAttribute:NSFontAttributeName value:self.tabItemCustomFont range:NSMakeRange(range.location, range.length)];
        }
    }
    
    label.attributedText = attStr;
    
    
}



@end
