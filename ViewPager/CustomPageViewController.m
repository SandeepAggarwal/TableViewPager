//
//  CustomPageViewController.m
//  Pods
//
//  Created by Sandeep Aggarwal on 25/08/16.
//
//

#import "CustomPageViewController.h"

@implementation CustomPageViewController

//for fixing a crash as suggested here http://stackoverflow.com/a/17330606/3632958
-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    if (!animated) {
        [super setViewControllers:viewControllers direction:direction animated:NO completion:completion];
        return;
    }
    
    [super setViewControllers:viewControllers direction:direction animated:YES completion:^(BOOL finished){
        
        if (finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [super setViewControllers:viewControllers direction:direction animated:NO completion:completion];
            });
        } else {
            if (completion != NULL) {
                completion(finished);
            }
        }
    }];
}

@end
