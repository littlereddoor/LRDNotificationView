//
//  LRDNotificationViewAnimations.m
//  LRDNotificationView Example
//
//  Created by Paul Morris on 30/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import "LRDNotificationViewAnimations.h"

@implementation LRDNotificationViewAnimations

+(void) beginAnimationWithDuration:(CGFloat)duration onView:(UIView *)notificationView withFrame:(CGRect)frame andOptions:(UIViewAnimationOptions)animationOptions andCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration: duration
                          delay: 0.0
                        options: animationOptions
                     animations:^{
                         [notificationView setFrame: frame];
                     }
                     completion:completion];
}

+(void) finishAnimationWithDelay:(CGFloat)delayArray withOptions:(UIViewAnimationOptions)animationOptions onView:(UIView *)notificationView withFrame:(CGRect)frame andCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.3
                          delay: delayArray * 0.20
                        options: animationOptions
                     animations:^{
                         [notificationView setFrame: frame];
                         [notificationView setAlpha: 0.0];
                     }
                     completion:completion];
}

@end
