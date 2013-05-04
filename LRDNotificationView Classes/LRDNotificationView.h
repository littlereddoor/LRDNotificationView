//
//  LRDNotificationView.h
//  LRDNotificationView
//
//  Created by Paul Morris on 26/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class LRDNotificationView;
@protocol LRDNotificationViewDelegate <NSObject>

-(void)notificationViewDidDismiss;

@end

@interface LRDNotificationView : NSObject

{
    
}

@property (nonatomic, strong) id <LRDNotificationViewDelegate> delegate;

// Public methods

/*******************************************************
 Shows a LRDNotificationView alert with a simple message.
 ******************************************************/
+(void) showInViewController:(UIViewController *)viewController withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;

/*****************************************************************
 Shows a LRDNotificationView alert with a title and simple message.
 ****************************************************************/
+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

/*******************************************************************************
 Shows a LRDNotificationView alert with an alert image, title and simple message.
 ******************************************************************************/
+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message withAlertImage:(UIImage *)image andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

/**********************************************************************************************
 Shows a Success styled LRDNotificationView alert with an alert image, title and simple message.
 **********************************************************************************************/
+(void) showSuccessNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

/**********************************************************************************************
 Shows a Error styled LRDNotificationView alert with an alert image, title and simple message.
 **********************************************************************************************/
+(void) showErrorNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

/**********************************************************************************************
 Shows a Warning styled LRDNotificationView alert with an alert image, title and simple message.
 **********************************************************************************************/
+(void) showWarningNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

/**********************************************************************************************
 Shows a General styled LRDNotificationView alert with an alert image, title and simple message.
 **********************************************************************************************/
+(void) showGeneralNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

@end


