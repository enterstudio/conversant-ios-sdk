//
//  iPhoneInfoViewController.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface iPhoneInfoViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UILabel *deviceId;
@property (nonatomic, retain) IBOutlet UILabel *deviceIdLabel;
@property (nonatomic, retain) IBOutlet UILabel *guidLabel;
@property (nonatomic, retain) IBOutlet UILabel *guidTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *sdkVersionLabel;

- (IBAction)openMail:(id)sender;

@end
