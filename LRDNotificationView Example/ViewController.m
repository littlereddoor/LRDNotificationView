//
//  ViewController.m
//  LRDNotificationView Example
//
//  Created by Paul Morris on 29/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import "ViewController.h"

#define deviceIsiPad UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self setTitle: @"LRDNotificationView"];
    
    if (deviceIsiPad)
    {
        [self.background setImage: [UIImage imageNamed:@"iPadWallpaper.png"]];
    }
    else
    {
        [self.background setImage: [UIImage imageNamed:@"iPhoneWallpaperRetina4.png"]];
    }
    
    UIButton *info = [UIButton buttonWithType: UIButtonTypeInfoDark];
    [info addTarget:self action:@selector(infoTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView: info];
    [self.navigationItem setRightBarButtonItem: rightItem];

}

-(void)infoTapped:(id)sender
{
    [LRDNotificationView showInViewController:self withTitle:@"Little Red Door Ltd." withMessage:@"WEBSITE: www.littlereddoor.co.uk\nEMAIL: hello@littlereddoor.co.uk\nTWITTER: @LittleRedDoorUK" andBackgroundColor:[UIColor redColor] andDelegate:self];
}

-(IBAction) simpleNotification:(id)sender
{
    [LRDNotificationView showInViewController: self withMessage: @"BREAKING NEWS: Ex Newcastle United Defender Titus Bramble has been found guilty of being a baffoon. More to follow on this story over at LittleRedDoor.co.uk" andBackgroundColor: [UIColor lightGrayColor] andDelegate:self];
}

-(IBAction) simpleNotificationWithTitle:(id)sender
{
    [LRDNotificationView showInViewController: self withTitle: @"Apple to announce new MacBook model at WWDC" withMessage: @"The latest Cupertino based speculation is suggesting that Apple are planning on using this year's WWDC event to introduce a new line of MacBook machines" andBackgroundColor: [UIColor blackColor] andDelegate:self];
}

-(IBAction) notificationwithTitleAndImage:(id)sender
{
    [LRDNotificationView showInViewController: self withTitle: @"Attchment failure!" withMessage: @"You wrote 'find the attached' in your message, but there are no files attached. Would you like to send anyway?" withAlertImage: [UIImage imageNamed:@"location.png"] andBackgroundColor: [UIColor colorWithRed:91./255 green:97./255 blue:124./255 alpha:1.0f] andDelegate:self];
    
}

-(IBAction) templateSuccessNotification:(id)sender
{
    [LRDNotificationView showSuccessNotificationInViewController: self withTitle: @"Request Complete" withMessage: @"Thank you very much for your interest in our range of innovative products. Your enquiry has been received and we aim to be in touch within 48 hours." andDelegate:self];
}

-(IBAction) templateErrorNotification:(id)sender
{
    [LRDNotificationView showErrorNotificationInViewController: self withTitle: @"Communication Error" withMessage: @"Please check your internet connection on the device and try again." andDelegate:self];
}

-(IBAction) templateWarningNotification:(id)sender
{
    [LRDNotificationView showWarningNotificationInViewController: self withTitle: @"Health Warning" withMessage: @"Food and drink that contain high sugar and saturated fat counts should be consumed in extreme moderation. Please consult your phsysician for more information." andDelegate:self];
}

-(IBAction) templateGeneralNotification:(id)sender
{
    [LRDNotificationView showGeneralNotificationInViewController: self withTitle: @"Request Complete" withMessage: @"Your requested song is ready for download. Please log in to your account to complete the process." andDelegate:self];
}

-(void) notificationViewDidDismiss
{
    NSLog(@"Notification View has been dismissed. Handle the relevant action accordingly.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
