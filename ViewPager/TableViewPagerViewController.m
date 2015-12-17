//
//  TableViewPagerViewController.m
//
//  Created by mac on 14/09/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import "TableViewPagerViewController.h"
#import "IndexedTableViewController.h"
#import "ScrollElement.h"



@interface TableViewPagerViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,HorizontalScrollViewDelegate>


@property NSArray* elementsName;
@property NSArray* colors;
@property UIView* coloredScroller;


@end

@implementation TableViewPagerViewController
{
    CGFloat min_scale;
    CGFloat min_alpha;
    BOOL tapped;
}


-(instancetype)initWithElementsName:(NSArray*)elements colors:(NSArray*)colors tableViews:(NSArray*)tableViews
{
    if (elements.count!=tableViews.count)
    {
        NSLog(@"count not same!!");
        return nil;
    }
    
    if (!(elements.count && tableViews.count))
    {
        NSLog(@"count=0");
        return nil;
    }
    
    self=[super init];
    if (self)
    {
        self.elementsName=elements;
        self.colors=colors;
        
        self.tableViewControllers=[[NSMutableArray alloc] init];
        for (int i=0; i<self.colors.count; i++)
        {
            IndexedTableViewController* vc=[[IndexedTableViewController alloc] init];
            vc.indexNumber=i;
            vc.tableView=[tableViews objectAtIndex:i];
            vc.refreshControl=[[UIRefreshControl alloc] init];
            vc.refreshControl.backgroundColor=[UIColor clearColor];
            [vc.refreshControl addTarget:self action:@selector(refreshControlValueChanged) forControlEvents:(UIControlEventValueChanged)];
            [self.tableViewControllers addObject:vc];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    min_scale = 0.80f;
    min_alpha  = 0.5f;
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //horizontal scroller
    CGFloat x=0;
    CGFloat y=0;
    CGFloat width=self.view.bounds.size.width;
    CGFloat height=40.0f;
    self.horizontalScrollView=[[HorizontalScrollView alloc] initWithFrame:CGRectMake(x, y, width, height) num_elements:self.elementsName.count];
    for (int i=0; i<self.elementsName.count; i++)
    {
      [self.horizontalScrollView  addNewScrollElement:[self.elementsName objectAtIndex:i] color:[self.colors objectAtIndex:i]];
    }
    [self.horizontalScrollView setHorizontalScrollViewDelegate:self];
    [self.view addSubview:self.horizontalScrollView];
 

   //page view controller
    x=0;
    y=self.horizontalScrollView.frame.origin.y+self.horizontalScrollView.bounds.size.height;
    width=self.view.bounds.size.width;
    height=self.view.bounds.size.height-y;
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate=self;
    [[self.pageController view] setFrame:CGRectMake(x,y,width,height)];
    [self.pageController setViewControllers:@[[self.tableViewControllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    //page scroll view
    UIScrollView*  pageScrollView= [self getScrollView:self.pageController];
    pageScrollView.delegate = self;
    self.pageScrollView=pageScrollView;
    
    //colored scroller
    x=self.horizontalScrollView.bounds.origin.x;
    height=8.0f;
    y=self.horizontalScrollView.bounds.origin.y+self.horizontalScrollView.bounds.size.height-height;
    width=self.horizontalScrollView.width_element;
    self.coloredScroller=[[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [self.coloredScroller setBackgroundColor:[self.colors objectAtIndex:0]];
    [self.horizontalScrollView addSubview:self.coloredScroller];
    
}

-(UIScrollView *)getScrollView:(UIPageViewController*)pageController
{
    UIScrollView *pageScrollView;
    for (UIView* view in pageController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            pageScrollView = (UIScrollView *)view;
            break;
        }
    }
    return pageScrollView;
}


#pragma mark -UIPageViewControllerDataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index=[(IndexedTableViewController*)viewController indexNumber];
    
    if (index==0)
    {
        return nil;
    }
    index--;
    return [self.tableViewControllers objectAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index=[(IndexedTableViewController*)viewController indexNumber];
    index++;
    if (index>self.tableViewControllers.count-1)
    {
        return nil;
    }
    return [self.tableViewControllers objectAtIndex:index];
}


#pragma mark -UIPageViewControllerDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //called when animate using pan
    if (completed==YES)
    {
        [self movetheScroller];
    }
}


#pragma mark -Helper methods

-(void)moveToViewController:(UIViewController*)controller direction: (UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated
{
    //called when tapped on scroll element or page controller view moves to its extreme ends
    __weak  typeof(self)weakSelf=self;
    [self.pageController setViewControllers:@[controller] direction:direction animated:animated completion:^(BOOL finished) {
        [weakSelf movetheScroller];
    }];
   
}

-(void)movetheScroller
{
    //current controller
    IndexedTableViewController* vc=[self.pageController.viewControllers firstObject];
    NSInteger index=vc.indexNumber;
    
    //select the element
    [self.horizontalScrollView setSelectedElementIndex:index ];
   
    //adjust the frame
    CGFloat x=self.horizontalScrollView.width_element*index;
    CGRect frame=self.coloredScroller.frame;
    frame.origin.x=x;
    [UIView transitionWithView:self.coloredScroller duration:0.2 options:(UIViewAnimationOptionAllowAnimatedContent) animations:^{
        self.coloredScroller.frame=frame;
    } completion:nil];
    
    //set the color
    UIColor *color=[self.colors objectAtIndex:index];
    [UIView animateWithDuration:0.2 animations:^{
        [self.coloredScroller.layer setBackgroundColor:color.CGColor];
    }];
}



#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([[self getScrollView:self.pageController] isEqual:scrollView])
    {
        IndexedTableViewController* vc=[self.pageController.viewControllers firstObject];
        IndexedTableViewController* next=(IndexedTableViewController*)[self pageViewController:self.pageController viewControllerAfterViewController:vc ];
        IndexedTableViewController* previous=(IndexedTableViewController*)[self pageViewController:self.pageController viewControllerBeforeViewController:vc ];
        
        CGFloat position=[self positionOfView:vc.view superView:self.view];
        
        //scroll present controller
        [self transformPage:vc.view position:position];
        
        [self transformScrollerWithPosition:position forVC:vc];
        
        if (next)
        {
            //scroll next controller
            [self transformPage:next.view position:position];
            
        }
        if (previous)
        {
            //scroll previous controller
             [self transformPage:previous.view position:position];
        }
        
        //when page controller view is at extreme ends
        if (position<=-0.8 && tapped==NO)
        {
            if (next)
            {
                [self moveToViewController:next direction:(UIPageViewControllerNavigationDirectionForward)animated:NO];
                
                //kill scrolling so that more than 2 views can't be seen
                // [self killScroll:scrollView];
            }
        }
        else if (position>=0.8 && tapped==NO)
        {
            if (previous)
            {
                [self moveToViewController:previous direction:(UIPageViewControllerNavigationDirectionReverse) animated:NO];
                
                //kill scrolling so that more than 2 views can't be seen
                // [self killScroll:scrollView];
            }
        }
  
    }
}



#pragma mark -Google code

-(CGFloat)positionOfView:(UIView*)view superView:(UIView*)superView
{
    CGFloat position;
    CGFloat screenWidth=self.view.bounds.size.width;
    CGFloat deltaX;
    
    CGFloat superViewCenter=superView.center.x;
    CGFloat viewCenter=[superView convertPoint:CGPointMake(view.center.x, view.center.y) fromView:view].x;
    deltaX=viewCenter-superViewCenter;
    position=(deltaX/screenWidth);
    return position;
}

-(void) transformPage:(UIView*)view position:(CGFloat)position
{
    if (position < -1)
    { // [-Infinity,-1)
        // This page is way off-screen to the left.
        [view setAlpha:0];
    }
    else if (position <= 1)
    { // [-1,1]
        
        // Modify the default slide transition to shrink the page as well
        CGFloat scaleFactor = fmaxf(min_scale, 1 - fabs(position));
        
        // Scale the page down (between MIN_SCALE and 1)
        CABasicAnimation* ba=[CABasicAnimation animationWithKeyPath:@"transform"];
        ba.autoreverses=NO;
        ba.duration=0;
        ba.fillMode=kCAFillModeForwards;
        ba.removedOnCompletion=NO;
    
        ba.toValue=[NSValue valueWithCATransform3D:(CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(scaleFactor, scaleFactor)))];
        
        [view.layer addAnimation:ba forKey:nil];
        
        // Fade the page relative to its size.
        [view setAlpha:(min_alpha +
                        (scaleFactor - min_scale) /
                        (1 - min_scale) * (1 - min_alpha)) ];
        
    }
    else
    { // (1,+Infinity]
        // This page is way off-screen to the right.
       [view setAlpha:0 ];
    }
}

-(void)transformScrollerWithPosition:(CGFloat)position forVC:(IndexedTableViewController*)vc
{
    //colored scroller
    NSInteger index=vc.indexNumber;
    CGFloat x=self.horizontalScrollView.width_element*(index- position);
    CGRect frame=self.coloredScroller.frame;
    frame.origin.x=x;
    self.coloredScroller.frame=frame;
    
    //set the color
    UIColor *color=[self.colors objectAtIndex:index];
    [UIView animateWithDuration:0.2 animations:^{
        [self.coloredScroller.layer setBackgroundColor:color.CGColor];
    }];
    
    if (position <= 1)
    { // [-1,1]
        
        CGFloat scaleFactor = fmaxf(0.4, 1 - fabs(position));
        
        // Scale the page down (between MIN_SCALE and 1)
        CABasicAnimation* ba=[CABasicAnimation animationWithKeyPath:@"transform"];
        ba.autoreverses=NO;
        ba.duration=0;
        ba.fillMode=kCAFillModeForwards;
        ba.removedOnCompletion=NO;
        
        ba.toValue=[NSValue valueWithCATransform3D:(CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1, scaleFactor)))];
      
        [self.coloredScroller.layer addAnimation:ba forKey:nil];
    }
  
}


#pragma mark -HorizontalScrollViewDelegate
-(void)selectedElementControlValueChangedFromIndex:(NSInteger)from to:(NSInteger)to
{
    if (from!=to)
    {
        IndexedTableViewController* vc=[self.tableViewControllers objectAtIndex:to];

        if ([self.pageController.viewControllers firstObject]!=vc)
        {
            //called only when tapped
            tapped=YES;
            UIPageViewControllerNavigationDirection direction=0;
            if (to > from)
            {
                direction=UIPageViewControllerNavigationDirectionForward;
            }
            else
            {
                direction=UIPageViewControllerNavigationDirectionReverse;
            }
            
            __weak typeof (self) weakSelf=self;
            [self.pageController setViewControllers:@[vc] direction:direction animated:YES completion:^(BOOL finished)
             {
                 tapped=NO;
                 [weakSelf movetheScroller];
             }];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadDataForElementIndex:)])
        {
            [self.delegate loadDataForElementIndex:to];
        }
    }
    
}

#pragma mark -UIRefreshControl
-(void)refreshControlValueChanged
{
    //current controller
    IndexedTableViewController* vc=[self.pageController.viewControllers firstObject];
    NSInteger index=vc.indexNumber;
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshDataForElementIndex:)])
    {
        [self.delegate refreshDataForElementIndex:index];
    }
 
}

@end
