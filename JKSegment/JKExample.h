//
//  JKExample.h
//  JKBaseKit
//
//  Created by 刘伟强 on 2017/5/23.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKExample : NSObject



@end

//-(void)createViews{
//    self.titleArr = @[@"全部评价",@"好评",@"中评",@"差评"];
//    self.slideView = [[DLCustomSlideView alloc]initWithFrame:self.view.bounds];
//    self.slideView.delegate = self;
//    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:6];
//    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
//    tabbar.tabItemNormalColor = KTextTitleColorlalala;
//    tabbar.tabItemSelectedColor = KFillFontColor;
//    tabbar.tabItemNormalFont = [UIFont systemFontOfSize:14];
//    tabbar.trackColor = KFillFontColor;
//    tabbar.trackViewHeight = 2;
//    tabbar.trackViewBottom = 2;
//    tabbar.backgroundColor = [UIColor whiteColor];
//    
//    NSMutableArray * itemArr = [NSMutableArray array];
//    for (NSString * str  in self.titleArr) {
//        DLScrollTabbarItem *item = [DLScrollTabbarItem itemWithTitle:str width:kMainScreenWidth/4];
//        [itemArr addObject:item];
//    }
//    tabbar.tabbarItems = itemArr;
//    
//    self.slideView.tabbar = tabbar;
//    self.slideView.cache = cache;
//    self.slideView.tabbarBottomSpacing = 0;
//    self.slideView.baseViewController = self;
//    [self.slideView setup];
//    [self.view addSubview:self.slideView];
//    self.slideView.selectedIndex = 0;
//    
//    
//}
//- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender{
//    return self.titleArr.count ;
//}
//
//- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index{
//    JKSubEvaluateViewControllerViewController * vc = [[JKSubEvaluateViewControllerViewController alloc] init];
//    
//    return vc;
//}
//- (void)DLCustomSlideView:(DLCustomSlideView *)sender didSelectedAt:(NSInteger)index{
//    JKSubEvaluateViewControllerViewController * vc = [sender.baseViewController.childViewControllers lastObject];
//    vc.pageNumber = 1;
//    if (index == 0) {
//        vc.type = kEvaluateTypeAll;
//    }else if (index == 1){
//        vc.type = kEvaluateTypeGood;
//    }else if (index == 2){
//        vc.type = kEvaluateTypeMiddle;
//    }else if (index == 3){
//        vc.type = kEvaluateTypeBad;
//    }
//    if (vc.dataArr.count == 0 && ![vc.view viewWithTag:500]) {
//        [vc updateWithIsFirst:YES];
//    }
//}
