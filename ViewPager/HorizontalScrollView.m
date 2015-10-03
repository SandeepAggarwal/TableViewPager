//
//  HorizontalScrollView.m

//
//  Created by mac on 24/03/15.
//  Copyright (c) 2015 Sandeep Aggarwal. All rights reserved.
//

#import "HorizontalScrollView.h"


@interface HorizontalScrollView ()<ScrollElementDelegate>

@property NSInteger num_elements;
@property ScrollElement* selectedElement;

@end

@implementation HorizontalScrollView
{
    CGFloat sizeFactor;
    
}


- (id)initWithFrame:(CGRect)frame num_elements:(NSInteger)num_elements
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.total_elements=num_elements;
        [self commonMethod];
    }
    return self;
}



-(void)commonMethod
{
    sizeFactor=1.0f;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setShowsHorizontalScrollIndicator:NO];
    _num_elements=0;
}

-(void)setTotal_elements:(NSInteger)total_elements
{
    _total_elements=total_elements;
    
    CGFloat minWidth=85;
    CGFloat width=self.bounds.size.width/(_total_elements);
    
    if (width>=minWidth)
    {
       _width_element=width;
    }
    else
    {
        NSInteger count=_total_elements;
        while (width<minWidth)
        {
            count--;
            if (count>0)
            {
              width=self.bounds.size.width/count;
            }
         }
        _width_element=width;
    }
    if (self.bounds.size.width<_width_element*_total_elements)
    {
       _width_element=_width_element-10.0f;
    }

    _selectedElementIndex=-1;
}

-(ScrollElement*)addNewScrollElement:(NSString*)text color:(UIColor*)color
{
    CGFloat width=_width_element;
    CGFloat x=_num_elements*width;
    CGFloat y=0;
    CGFloat height=self.bounds.size.height;
    
    ScrollElement* scrollElement=[[ScrollElement alloc] initWithFrame:CGRectMake(x, y, width, height)];
    scrollElement.index=_num_elements;
    [scrollElement setLabel:text color:color];
    scrollElement.delegate=self;
    [self addSubview:scrollElement];
    
    self.contentSize=CGSizeMake(scrollElement.frame.origin.x+scrollElement.bounds.size.width, self.frame.size.height);
    
    _num_elements++;
    return scrollElement;
}

-(void)setSelectedElementIndex:(NSInteger)selectedElementIndex
{
    _selectedElementIndex=selectedElementIndex;
    for (ScrollElement* element in self.subviews)
    {
        if ([element isKindOfClass:[ScrollElement class]] && element.index==selectedElementIndex)
        {
            [element select];
             break;
        }
    }
}

#pragma mark -ScrollElementDelegate
-(void)ScrollElementTapped:(ScrollElement*)sender
{
    NSInteger previousElementIndex=-1;
    if (_selectedElement)
    {
        previousElementIndex=_selectedElement.index;
        [_selectedElement deSelect];
    }
    _selectedElement=sender;
    _selectedElementIndex=sender.index;
    
    UIView* superView=self.superview;
    
    CGFloat lastElementEndLocX=(_total_elements)*_width_element;
    CGFloat offset=self.contentOffset.x;
    
    if (_selectedElementIndex!=previousElementIndex)
    {
        if (_selectedElementIndex>previousElementIndex)
        {
            if ((superView.frame.origin.x+superView.bounds.size.width)<([superView convertPoint:CGPointMake(lastElementEndLocX, 0) fromView:self]).x && _selectedElementIndex>0 )
            {
                //shift the scroller
                offset=self.contentSize.width-self.bounds.size.width;
                if (offset>_selectedElementIndex*_width_element)
                {
                    offset=_selectedElementIndex*_width_element;
                }
            }
        }
        else if(_selectedElementIndex<previousElementIndex)
        {
            if ((superView.frame.origin.x)>([superView convertPoint:CGPointMake(0, 0) fromView:self]).x && _selectedElementIndex<(_total_elements-1) )
            {
                //shift the scroller
                offset=self.frame.origin.x;
                if (offset+superView.bounds.size.width<((_selectedElementIndex+1)*_width_element))
                {
                    offset=((_selectedElementIndex+1)*_width_element)-superView.bounds.size.width;
                }
            }
        }
        
        if (offset!=self.contentOffset.x)
        {
            [self setContentOffset:CGPointMake(offset, 0) animated:YES];
        }
        
        if (self.horizontalScrollViewDelegate && [self.horizontalScrollViewDelegate respondsToSelector:@selector(selectedElementControlValueChangedFromIndex:to:)])
        {
            [self.horizontalScrollViewDelegate selectedElementControlValueChangedFromIndex:previousElementIndex to:_selectedElementIndex];
        }
    }
    
    
}



@end
