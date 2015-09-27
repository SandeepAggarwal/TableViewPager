//
//  ScrollElement.h
//
//  Created by mac on 24/03/15.
//  Copyright (c) 2015 smartsandeep1129@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollElementDelegate <NSObject>
-(void)ScrollElementTapped:(id)sender;
@end

@interface ScrollElement : UIControl

@property NSInteger index;
@property (nonatomic, weak) id<ScrollElementDelegate>delegate;
-(void)setLabel:(NSString*)text color:(UIColor*)color;
-(void)select;
-(void)deSelect;

@end