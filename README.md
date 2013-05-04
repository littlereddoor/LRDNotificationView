LRDNavigationView
=================

A lightweight Objective-C class to create a semi-obtrusive notification view that emanates from the navigation or status bar of an iPhone or iPad application. Can be thought of along the lines of the error messages found in Tweetbot for 
iPhone but with the ability to pass in the title, notification message and any required notification image.

Instructions For Use
====================

1) Copy the 'LRDNotificationView Classes' folder and its contents into your Xcode project.

2) Copy the 'LRDNotificationView Assets' folder and its contents into your Xcode project.

3) Make sure that the QuartzCore framework is added to your Xcode project.

Available Methods
=================

    +(void) showInViewController:(UIViewController *)viewController 
            withMessage:(NSString *)message 
            andBackgroundColor:(UIColor *)backgroundColor 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;

    +(void) showInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            andBackgroundColor:(UIColor *)backgroundColor 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

    +(void) showInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            withAlertImage:(UIImage *)image andBackgroundColor:(UIColor *)backgroundColor 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

    +(void) showSuccessNotificationInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

    +(void) showErrorNotificationInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

    +(void) showWarningNotificationInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

    +(void) showGeneralNotificationInViewController:(UIViewController *)viewController 
            withTitle:(NSString *)title withMessage:(NSString *)message 
            andDelegate:(id<LRDNotificationViewDelegate>)delegate;

Example Usage
=============

    [LRDNotificationView showInViewController: self 
                        withMessage: @"This is a LRDNotificationView made up of a message and user defined background color" 
                        andBackgroundColor: [UIColor lightGrayColor] 
                        andDelegate:self];
    
Delegate Method
===============

Users can subscribe to the ```<LRDNotificationViewDelegate>``` protocol to allow the class to inform their calling view controller when the alert has been dismissed. The application can then perform whatever task is necessary.

Example Application
===================

The included sample application shows an instance of each of the different alert types in action. The notification is presented on a view controller and therefore works in portrait mode with the iPhone and iPad applications.

Still To-Do
===============

LRDNotificationView was created as a simple alert view for an internal application. There are plenty of ways that the code and implementation of such a control can be improved.
- Support for landscape mode.
- Support for varying animations to display the alert.
- Potentially allowing the notification to be displayed from bottom of the view or the sides.
    
