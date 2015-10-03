//
//  TableViewPagerViewController.h
//
//  Created by mac on 14/09/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalScrollView.h"


@protocol TableViewPagerViewControllerDelegate <NSObject>

-(void)loadDataForElementIndex:(NSInteger)index;
-(void)refreshDataForElementIndex:(NSInteger)index;

@end

@interface TableViewPagerViewController : UIViewController

@property id<TableViewPagerViewControllerDelegate> delegate;
@property HorizontalScrollView* horizontalScrollView;
@property (strong, nonatomic) UIPageViewController *pageController;
-(instancetype)initWithElementsName:(NSArray*)elements colors:(NSArray*)colors tableViews:(NSArray*)tableViews;
@property NSMutableArray* tableViewControllers;
@end
