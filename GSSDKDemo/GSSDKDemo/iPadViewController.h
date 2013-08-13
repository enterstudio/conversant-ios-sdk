//
//  iPadViewController.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "GSAdDelegate.h"

@class GSLeaderboardAdView;
@class GSMediumRectangleAdView;
@class GSFullscreenAd;

@interface iPadViewController : UIViewController <GSAdDelegate, MFMailComposeViewControllerDelegate> {
    GSLeaderboardAdView *myLeaderboardAd;
    GSMediumRectangleAdView *myMediumRectangleAd;
}

@property (nonatomic, retain) GSFullscreenAd *myFullscreenAd;

@property (nonatomic, retain) IBOutlet UILabel *deviceId;
@property (nonatomic, retain) IBOutlet UILabel *deviceIdLabel;
@property (nonatomic, retain) IBOutlet UILabel *guidLabel;
@property (nonatomic, retain) IBOutlet UILabel *guidTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *sdkVersionLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UIButton *displayFullscreenButton;
@property (nonatomic, retain) IBOutlet UIButton *fetchFullscreenButton;
@property (nonatomic, retain) IBOutlet UIButton *leaderboardButton;
@property (nonatomic, retain) IBOutlet UIButton *mediumRectangleButton;

//Button actions
- (IBAction)displayFullscreenButtonPressed:(id)sender;
- (IBAction)fetchFullscreenButtonPressed:(id)sender;
- (IBAction)leaderboardButtonPressed:(id)sender;
- (IBAction)mediumRectangleButtonPressed:(id)sender;
- (IBAction)openMail:(id)sender;

@end