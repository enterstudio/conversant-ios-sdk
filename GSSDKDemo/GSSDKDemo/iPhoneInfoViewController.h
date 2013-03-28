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

@property (strong, nonatomic) IBOutlet UILabel* guidTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel* guidLabel;
@property (strong, nonatomic) IBOutlet UILabel* hashedIdLabel;
@property (strong, nonatomic) IBOutlet UILabel* sdkVersionLabel;

- (IBAction)openMail:(id)sender;

@end
