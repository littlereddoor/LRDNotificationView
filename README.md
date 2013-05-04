LRDNavigationView
=================

A lightweight Objective-C class to create a semi-obtrusive notification view that emanates from the navigation or status bar of an iPhone or iPad application. Can be thought of along the lines of the error messages found in Tweetbot for 
iPhone but with the ability to pass in the title, notification message and any required notification image.

INSTRUCTIONS FOR USE

1) Copy the 'LRDNotificationView Classes' folder and its contents into your Xcode project.
2) Copy the 'LRDNotificationView Assets' folder and its contents into your Xcode project.
3) Make sure that the QuartzCore framework is added to your Xcode project.

AVAILABLE METHODS

+(void) showInViewController:(UIViewController *)viewController withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;

+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message withAlertImage:(UIImage *)image andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

+(void) showSuccessNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

+(void) showErrorNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

+(void) showWarningNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;;

+(void) showGeneralNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate;

