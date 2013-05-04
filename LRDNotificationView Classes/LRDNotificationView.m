//
//  LRDNotificationView.m
//  LRDNotificationView
//
//  Created by Paul Morris on 26/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import "LRDNotificationView.h"
#import "LRDNotificationViewAnimations.h"

// Variety of constants used throughout
#define LEFT_BUFFER             20 // Distance from the extreme left of the notification to the beginning of the text
#define TOP_BUFFER              8 // Distance from the extreme top of the notification to the Y position of the top most label
#define TITLE_MESSAGE_BUFFER    5 // Distance between the the end of the Title label and the beginning of the Message label
#define ICON_SIZE               32 // We only allow images of 32x32. This looks best in the alert.
#define ICON_LEFT_BUFFER        15 // Distance from the extreme left of the notification to the X position of the icon
#define ANIMATION_TIME          0.20f // default animation display time

// Font constants. Changing these will change the font used in the notificationView. The view will resize correctly.
#define DEFAULT_MESSAGE_FONT    [UIFont boldSystemFontOfSize: 12]
#define DEFAULT_TITLE_FONT      [UIFont boldSystemFontOfSize: 14]

// Gradient constants used in the formation of the Success, Error, Warning and General alert types.
#define SUCCESS_GRADIENT_COLOR    [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:136./255 green:215./255 blue:114./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:138./255 green:216./255 blue:115./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:135./255 green:213./255 blue:122./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:131./255 green:210./255 blue:119./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:123./255 green:199./255 blue:111./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:120./255 green:195./255 blue:108./255 alpha:0.9] CGColor], nil];

#define ERROR_GRADIENT_COLOR    [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:238./255 green:59./255 blue:56./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:239./255 green:64./255 blue:61./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:238./255 green:71./255 blue:68./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:233./255 green:74./255 blue:71./255 alpha:0.9] CGColor], nil];

#define WARNING_GRADIENT_COLOR    [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:247./255 green:244./255 blue:23./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:247./255 green:244./255 blue:23./255 alpha:0.9] CGColor],(id)[[UIColor colorWithRed:247./255 green:244./255 blue:23./255 alpha:0.9] CGColor],(id)[[UIColor colorWithRed:247./255 green:244./255 blue:23./255 alpha:0.9] CGColor], nil];

#define GENERAL_GRADIENT_COLOR    [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:172./255 green:218./255 blue:226./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:158./255 green:213./255 blue:222./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:146./255 green:210./255 blue:221./255 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:137./255 green:210./255 blue:223./255 alpha:0.9] CGColor], nil];

// Image display options
#define PINNED_TO_TOP           CGRectMake(ICON_LEFT_BUFFER, TOP_BUFFER, ICON_SIZE, ICON_SIZE)];
#define FLOAT_IN_CENTRE         CGRectMake(ICON_LEFT_BUFFER, (newFrame.size.height - ICON_SIZE) / 2, ICON_SIZE, ICON_SIZE)]

@implementation LRDNotificationView

// Wrapper to allow us to get the height and width of the label required for the passed in text.
+(CGSize)getHeightForString:(NSString *)string withConstraints:(CGSize)constraints andFont:(UIFont *)font
{
    //Calculate the size of the text
    CGSize heightOfString = [string sizeWithFont: font constrainedToSize:CGSizeMake(constraints.width, constraints.height) lineBreakMode: NSLineBreakByWordWrapping];

    return heightOfString;
}

+(void) showInViewController:(UIViewController *)viewController withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate
{    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (LEFT_BUFFER * 2), MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor whiteColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake(LEFT_BUFFER, TOP_BUFFER, (viewController.view.frame.size.width) - (LEFT_BUFFER * 2), messageStringSize.height)];
    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2);
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER *2));
    [notificationView setBackgroundColor: backgroundColor];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationMessageLabel];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];
    
}

+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    if (([title isEqualToString: @""]) || (title == nil))
    {
        [self showInViewController: viewController withMessage:message andBackgroundColor:backgroundColor andDelegate: delegate];
    }
    else
    {
        
        UILabel *notificationTitleLabel = [[UILabel alloc] init];
        CGSize notificationTitleLabelBounds = CGSizeMake((viewController.view.frame.size.width) - (LEFT_BUFFER * 2), MAXFLOAT);
        CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
        [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
        [notificationTitleLabel setNumberOfLines: 0];
        [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
        [notificationTitleLabel setTextColor: [UIColor whiteColor]];
        [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
        [notificationTitleLabel setFrame: CGRectMake(LEFT_BUFFER, TOP_BUFFER, (viewController.view.frame.size.width) - (LEFT_BUFFER * 2), titleStringSize.height)];
        [notificationTitleLabel setShadowColor: [UIColor blackColor]];
        [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
        [notificationTitleLabel setText: title];
        
        UILabel *notificationMessageLabel = [[UILabel alloc] init];
        // set the properties of the notification label
        CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (LEFT_BUFFER * 2), MAXFLOAT);
        CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
        [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
        [notificationMessageLabel setNumberOfLines: 0];
        [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
        [notificationMessageLabel setTextColor: [UIColor whiteColor]];
        [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
        [notificationMessageLabel setFrame: CGRectMake(LEFT_BUFFER, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, (viewController.view.frame.size.width) - (LEFT_BUFFER * 2), messageStringSize.height)];
        [notificationMessageLabel setShadowColor: [UIColor blackColor]];
        [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
        [notificationMessageLabel setText: message];
        
        // Set the properties of the underlying view that holds the content
        UIView *notificationView = [[UIView alloc] init];
        CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
        CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
        CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
        [notificationView setBackgroundColor: backgroundColor];
        [notificationView setAlpha: 0.9];
        [notificationView setFrame: startingFrame];
        
        // Adjusting the layer properties of the view.
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
        [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
        [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
        [notificationView.layer setShadowOpacity: 0.7];
        [notificationView.layer setShadowRadius:1.0];
        [notificationView.layer setShadowPath: shadowPath.CGPath];
        [notificationMessageLabel.layer setShouldRasterize: YES];
        
        [viewController.view addSubview:notificationView];
        [notificationView addSubview: notificationTitleLabel];
        [notificationView addSubview: notificationMessageLabel];
        
        // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
        CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
        
        [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
            [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
                [delegate notificationViewDidDismiss];
                [notificationView removeFromSuperview];
            }];
            
        }];

    }
    
}

+(void) showInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message withAlertImage:(UIImage *)image andBackgroundColor:(UIColor *)backgroundColor andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    
    UILabel *notificationTitleLabel = [[UILabel alloc] init];
    CGSize notificationTitleLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
    [notificationTitleLabel setNumberOfLines: 0];
    [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationTitleLabel setTextColor: [UIColor whiteColor]];
    [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER, titleStringSize.width, titleStringSize.height)];
    [notificationTitleLabel setShadowColor: [UIColor blackColor]];
    [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationTitleLabel setText: title];
    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor whiteColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, messageStringSize.width, messageStringSize.height)];
    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
    [notificationView setBackgroundColor: backgroundColor];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Creating our little imageView to hold alert icon
    UIImageView *notificationAlertImage = [[UIImageView alloc] init];
    [notificationAlertImage setImage: image];
    //[notificationAlertImage setFrame: FLOAT_IN_CENTRE; // uncomment this code to make sure the picture is located horiz in the centre of the view
    [notificationAlertImage setFrame: PINNED_TO_TOP; // comment this out if above is uncommented.
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationTitleLabel];
    [notificationView addSubview: notificationMessageLabel];
    [notificationView addSubview: notificationAlertImage];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    // Perform the initial animation to bring the view in
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];
}

+(void) showSuccessNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    
    UILabel *notificationTitleLabel = [[UILabel alloc] init];
    CGSize notificationTitleLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
    [notificationTitleLabel setNumberOfLines: 0];
    [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationTitleLabel setTextColor: [UIColor whiteColor]];
    [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER, titleStringSize.width, titleStringSize.height)];
    [notificationTitleLabel setShadowColor: [UIColor blackColor]];
    [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationTitleLabel setText: title];
    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor whiteColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, messageStringSize.width, messageStringSize.height)];
    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
    [notificationView setBackgroundColor: [UIColor clearColor]];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Creating a gradient type layer using CAGradientLayer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = notificationView.bounds;
    gradient.colors = SUCCESS_GRADIENT_COLOR;
    [notificationView.layer insertSublayer:gradient atIndex:0];
    
    // Creating our little imageView to hold alert icon
    UIImageView *notificationAlertImage = [[UIImageView alloc] init];
    [notificationAlertImage setImage: [UIImage imageNamed:@"successIcon.png"]];
//    [notificationAlertImage setFrame: FLOAT_IN_CENTRE;
    [notificationAlertImage setFrame: PINNED_TO_TOP;
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationTitleLabel];
    [notificationView addSubview: notificationMessageLabel];
    [notificationView addSubview: notificationAlertImage];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];
}
+(void) showErrorNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    
    UILabel *notificationTitleLabel = [[UILabel alloc] init];
    CGSize notificationTitleLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
    [notificationTitleLabel setNumberOfLines: 0];
    [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationTitleLabel setTextColor: [UIColor whiteColor]];
    [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER, titleStringSize.width, titleStringSize.height)];
    [notificationTitleLabel setShadowColor: [UIColor blackColor]];
    [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationTitleLabel setText: title];
    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor whiteColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, messageStringSize.width, messageStringSize.height)];
    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
    [notificationView setBackgroundColor: [UIColor clearColor]];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Creating a gradient type layer using CAGradientLayer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = notificationView.bounds;
    gradient.colors = ERROR_GRADIENT_COLOR;
    [notificationView.layer insertSublayer:gradient atIndex:0];
    
    // Creating our little imageView to hold alert icon
    UIImageView *notificationAlertImage = [[UIImageView alloc] init];
    [notificationAlertImage setImage: [UIImage imageNamed:@"errorIcon.png"]];
//    [notificationAlertImage setFrame: FLOAT_IN_CENTRE;
    [notificationAlertImage setFrame: PINNED_TO_TOP;
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationTitleLabel];
    [notificationView addSubview: notificationMessageLabel];
    [notificationView addSubview: notificationAlertImage];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];
}

+(void) showWarningNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    
    UILabel *notificationTitleLabel = [[UILabel alloc] init];
    CGSize notificationTitleLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
    [notificationTitleLabel setNumberOfLines: 0];
    [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationTitleLabel setTextColor: [UIColor blackColor]];
    [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER, titleStringSize.width, titleStringSize.height)];
//    [notificationTitleLabel setShadowColor: [UIColor blackColor]];
//    [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationTitleLabel setText: title];
    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString:message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor blackColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, messageStringSize.width, messageStringSize.height)];
//    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
//    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
    [notificationView setBackgroundColor: [UIColor clearColor]];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Creating a gradient type layer using CAGradientLayer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = notificationView.bounds;
    gradient.colors = WARNING_GRADIENT_COLOR;
    [notificationView.layer insertSublayer:gradient atIndex:0];
    
    // Creating our little imageView to hold alert icon
    UIImageView *notificationAlertImage = [[UIImageView alloc] init];
    [notificationAlertImage setImage: [UIImage imageNamed:@"warningIcon.png"]];
//    [notificationAlertImage setFrame: FLOAT_IN_CENTRE;
    [notificationAlertImage setFrame: PINNED_TO_TOP;
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationTitleLabel];
    [notificationView addSubview: notificationMessageLabel];
    [notificationView addSubview: notificationAlertImage];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];

}

+(void) showGeneralNotificationInViewController:(UIViewController *)viewController withTitle:(NSString *)title withMessage:(NSString *)message andDelegate:(id<LRDNotificationViewDelegate>)delegate
{
    
    UILabel *notificationTitleLabel = [[UILabel alloc] init];
    CGSize notificationTitleLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize titleStringSize = [self getHeightForString: title withConstraints: notificationTitleLabelBounds andFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setBackgroundColor: [UIColor clearColor]];
    [notificationTitleLabel setNumberOfLines: 0];
    [notificationTitleLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationTitleLabel setTextColor: [UIColor whiteColor]];
    [notificationTitleLabel setFont: DEFAULT_TITLE_FONT];
    [notificationTitleLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER, titleStringSize.width, titleStringSize.height)];
    [notificationTitleLabel setShadowColor: [UIColor blackColor]];
    [notificationTitleLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationTitleLabel setText: title];
    
    UILabel *notificationMessageLabel = [[UILabel alloc] init];
    // set the properties of the notification label
    CGSize notificationMessageLabelBounds = CGSizeMake ((viewController.view.frame.size.width) - (ICON_LEFT_BUFFER * 3) - ICON_SIZE, MAXFLOAT);
    CGSize messageStringSize = [self getHeightForString: message withConstraints: notificationMessageLabelBounds andFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setBackgroundColor: [UIColor clearColor]];
    [notificationMessageLabel setNumberOfLines: 0];
    [notificationMessageLabel setTextAlignment: NSTextAlignmentLeft];
    [notificationMessageLabel setTextColor: [UIColor whiteColor]];
    [notificationMessageLabel setFont: DEFAULT_MESSAGE_FONT];
    [notificationMessageLabel setFrame: CGRectMake((ICON_LEFT_BUFFER * 2) + ICON_SIZE, TOP_BUFFER + titleStringSize.height + TITLE_MESSAGE_BUFFER, messageStringSize.width, messageStringSize.height)];
    [notificationMessageLabel setShadowColor: [UIColor blackColor]];
    [notificationMessageLabel setShadowOffset: CGSizeMake(0, -0.5)];
    [notificationMessageLabel setText: message];
    
    // Set the properties of the underlying view that holds the content
    UIView *notificationView = [[UIView alloc] init];
    CGFloat frameStartingPositionYHeight = (notificationMessageLabel.frame.size.height) + (notificationTitleLabel.frame.size.height) + (TOP_BUFFER * 2) + TITLE_MESSAGE_BUFFER;
    CGRect startingFrame = CGRectMake(0, - frameStartingPositionYHeight, viewController.view.frame.size.width, frameStartingPositionYHeight);
    CGRect newFrame = CGRectMake(0, 0, viewController.view.frame.size.width, (notificationMessageLabel.frame.size.height) + (TOP_BUFFER * 2) + (notificationTitleLabel.frame.size.height) + TITLE_MESSAGE_BUFFER);
    [notificationView setBackgroundColor: [UIColor clearColor]];
    [notificationView setAlpha: 0.9];
    [notificationView setFrame: startingFrame];
    
    // Creating a gradient type layer using CAGradientLayer
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = notificationView.bounds;
    gradient.colors = GENERAL_GRADIENT_COLOR;
    [notificationView.layer insertSublayer:gradient atIndex:0];
    
    // Creating our little imageView to hold alert icon
    UIImageView *notificationAlertImage = [[UIImageView alloc] init];
    [notificationAlertImage setImage: [UIImage imageNamed:@"generalIcon.png"]];
//    [notificationAlertImage setFrame: FLOAT_IN_CENTRE;
    [notificationAlertImage setFrame: PINNED_TO_TOP;
    
    // Adjusting the layer properties of the view.
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect: newFrame];
    [notificationView.layer setShadowColor: [UIColor blackColor].CGColor];
    [notificationView.layer setShadowOffset: CGSizeMake(0, 1)];
    [notificationView.layer setShadowOpacity: 0.7];
    [notificationView.layer setShadowRadius:1.0];
    [notificationView.layer setShadowPath: shadowPath.CGPath];
    [notificationMessageLabel.layer setShouldRasterize: YES];
    
    [viewController.view addSubview:notificationView];
    [notificationView addSubview: notificationTitleLabel];
    [notificationView addSubview: notificationMessageLabel];
    [notificationView addSubview: notificationAlertImage];
    
    // Getting the number of words in the passed in message. This allows us to calculate the time that the alert should be displayed for based on the average guidelines for words per minute reading.
    CGFloat numberOfWords = [notificationMessageLabel.text componentsSeparatedByString: @" "].count;
    
    [LRDNotificationViewAnimations beginAnimationWithDuration:ANIMATION_TIME onView:notificationView withFrame:newFrame andOptions:UIViewAnimationOptionCurveLinear andCompletion:^(BOOL finished) {
        [LRDNotificationViewAnimations finishAnimationWithDelay:numberOfWords withOptions:UIViewAnimationOptionCurveLinear onView:notificationView withFrame:startingFrame andCompletion:^(BOOL finished) {
            [delegate notificationViewDidDismiss];
            [notificationView removeFromSuperview];
        }];
        
    }];

}

@end
