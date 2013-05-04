//
//  ViewController.h
//  LRDNotificationView Example
//
//  Created by Paul Morris on 29/04/2013.
//  Copyright (c) 2013 Little Red Door Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRDNotificationView.h"

@interface ViewController : UIViewController <LRDNotificationViewDelegate>

{
    
}

@property (nonatomic, weak) IBOutlet UIImageView            *background;

-(IBAction) simpleNotification:(id)sender;
-(IBAction) simpleNotificationWithTitle:(id)sender;
-(IBAction) notificationwithTitleAndImage:(id)sender;
-(IBAction) templateSuccessNotification:(id)sender;
-(IBAction) templateErrorNotification:(id)sender;
-(IBAction) templateWarningNotification:(id)sender;
-(IBAction) templateGeneralNotification:(id)sender;

@end
