# Table-View-Pager
===========

The Table-View-Pager is for iOS which is somewhat similar to Android's view-pager.

Slide through the table views with transition including scaling up and down of table-views!!

![Table-View-Pager] (http://i.imgur.com/sCkySFS.gifv)


## Installation
Just copy following files to your project:

HorizontalScrollView.h
HorizontalScrollView.m
IndexedTableViewController.h
IndexedTableViewController.m
ScrollElement.h
ScrollElement.m
TableViewPagerViewController.h
TableViewPagerViewController.m

## Usage

import 'TableViewPagerViewController'

Initialize table views

```
UITableView* v1=[[UITableView alloc] init];
UITableView* v2=[[UITableView alloc] init];
UITableView* v3=[[UITableView alloc] init];
UITableView* v4=[[UITableView alloc] init];
UITableView* v5=[[UITableView alloc] init];

```

Initialize TableViewPagerViewController

```
TableViewPagerViewController *container = [[TableViewPagerViewController alloc] initWithElementsName:@[@"ONE",@"TWO",@"THREE",@"FOUR",@"FIVE"] colors:@[ONE_TAB_COLOR,TWO_TAB_COLOR,THREE_TAB_COLOR,FOUR_TAB_COLOR,FIVE_TAB_COLOR] tableViews:@[v1,v2,v3,v4,v5]];
    [self addChildViewController:container];
    [self.view addSubview:container.view];
    [container didMoveToParentViewController:self];
    container.delegate=self;
 ```
 
 
### Methods
 
 TableViewPagerViewController will alert your delegate object via `- loadDataForElementIndex:` method, so that you can
 do something useful upon changing the tab
 
 
 ```
 #pragma mark -TableViewPagerViewControllerDelegate
-(void)loadDataForElementIndex:(NSInteger)index
{
    /*
    index=0, for first tab
    index=1 , for second tab
    
    and so on..
    */
}
```

## Requirements

ViewPager supports minimum iOS 7 and uses ARC.

Supports both iPhone and iPad.

## Contact
[@sandeepCool77](https://twitter.com/sandeepCool77)

[Sandeep Aggarwal](mailto:smartsandeep1129@gmail.com)


