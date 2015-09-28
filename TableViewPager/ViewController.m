//
//  ViewController.m
//  TableViewPager
//
//  Created by mac on 27/09/15.
//  Copyright © 2015 Sandeep Aggarwal. All rights reserved.
//

#import "ViewController.h"
#import "TableViewPagerViewController.h"

#define UIColorFromRGB(rgbValue, opacity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]


#define ONE_TAB_COLOR  UIColorFromRGB(0x274e79, 1.0)

#define TWO_TAB_COLOR  UIColorFromRGB(0X05af6e, 1.0)

#define THREE_TAB_COLOR  UIColorFromRGB(0xffaa23, 1.0)

#define FOUR_TAB_COLOR   UIColorFromRGB(0X45c3f7, 1.0)

#define FIVE_TAB_COLOR  UIColorFromRGB(0xfb2727, 1.0)

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewPagerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UITableView* v1=[[UITableView alloc] init];
    [v1 setBackgroundColor:ONE_TAB_COLOR];
    [v1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    v1.dataSource=self;
    v1.delegate=self;

     UITableView* v2=[[UITableView alloc] init];
    [v2 setBackgroundColor:TWO_TAB_COLOR];
     [v2 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    v2.dataSource=self;
    v2.delegate=self;

     UITableView* v3=[[UITableView alloc] init];
    [v3 setBackgroundColor:THREE_TAB_COLOR];
    [v3 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    v3.dataSource=self;
    v3.delegate=self;

     UITableView* v4=[[UITableView alloc] init];
    [v4 setBackgroundColor:FOUR_TAB_COLOR];
    [v4 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    v4.dataSource=self;
    v4.delegate=self;

     UITableView* v5=[[UITableView alloc] init];
    [v5 setBackgroundColor:FIVE_TAB_COLOR];
    [v5 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    v5.dataSource=self;
    v5.delegate=self;


    TableViewPagerViewController *container = [[TableViewPagerViewController alloc] initWithElementsName:@[@"ONE",@"TWO",@"THREE",@"FOUR",@"FIVE"] colors:@[ONE_TAB_COLOR,TWO_TAB_COLOR,THREE_TAB_COLOR,FOUR_TAB_COLOR,FIVE_TAB_COLOR] tableViews:@[v1,v2,v3,v4,v5]];
    [self addChildViewController:container];
    [self.view addSubview:container.view];
    [container didMoveToParentViewController:self];
    container.delegate=self;
    
    CGRect frame=container.view.frame;
    frame.origin.y=50.0f;
    container.view.frame=frame;
}

#pragma mark -Table View data source
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark -TableViewPagerViewControllerDelegate
-(void)loadDataForElementIndex:(NSInteger)index
{
    
}


@end
