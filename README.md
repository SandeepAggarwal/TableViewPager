# Table View Pager for iOS
====================

[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/TableViewPager.svg)](https://img.shields.io/cocoapods/v/TableViewPager.svg)
[![Platform](https://img.shields.io/cocoapods/p/TableViewPager.svg?style=flat)](http://cocoadocs.org/docsets/TableViewPager)

A simple 'Table View Pager' for iOS which is inspired by Android's view pager. It is useful for applications having requirement of multiple table views which requires switching with the help of different tabs in one ViewController.

Slide through the table views with beautiful transitions!!

<img src="http://s15.postimg.org/kuyfnxyxn/ezgif_com_video_to_gif.gif" alt="Table-View-Pager"  style="width:268;height:480">


### Installation with CocoaPods

#### Podfile

```ruby
pod "TableViewPager"
```


## Usage

```objective-c
#import <TableViewPager/TableViewPagerViewController.h>
```

Initialize table views

```objective-c
UITableView* v1=[[UITableView alloc] init];
UITableView* v2=[[UITableView alloc] init];
UITableView* v3=[[UITableView alloc] init];
UITableView* v4=[[UITableView alloc] init];
UITableView* v5=[[UITableView alloc] init];

```

Initialize TableViewPagerViewController

```objective-c
TableViewPagerViewController *container = [[TableViewPagerViewController alloc] initWithElementsName:@[@"ONE",@"TWO",@"THREE",@"FOUR",@"FIVE"] colors:@[ONE_TAB_COLOR,TWO_TAB_COLOR,THREE_TAB_COLOR,FOUR_TAB_COLOR,FIVE_TAB_COLOR] tableViews:@[v1,v2,v3,v4,v5]];
    [self addChildViewController:container];
    [self.view addSubview:container.view];
    [container didMoveToParentViewController:self];
    container.delegate=self;
 ```
 
 
### Methods
 
 TableViewPagerViewController will alert your delegate object via `- loadDataForElementIndex:` method, so that you can
 do something useful upon changing the tab
 
 
 ```objective-c
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

## License

TableViewPager is released under the MIT license. See LICENSE for details.


