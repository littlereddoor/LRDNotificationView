//
//  LRDNotificationViewAnimations.h
//  LRDNotificationView Example
//
//  Created by Paul Morris on 30/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRDNotificationViewAnimations : NSObject

+(void) beginAnimationWithDuration:(CGFloat)duration onView:(UIView *)notificationView withFrame:(CGRect)frame andOptions:(UIViewAnimationOptions)animationOptions andCompletion:(void (^)(BOOL finished))completion;
+(void) finishAnimationWithDelay:(CGFloat)delayArray withOptions:(UIViewAnimationOptions)animationOptions onView:(UIView *)notificationView withFrame:(CGRect)frame andCompletion:(void (^)(BOOL finished))completion;

@end
