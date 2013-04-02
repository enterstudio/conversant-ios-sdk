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
#import "GSLeaderboardAdView.h"
#import "GSMediumRectangleAdView.h"
#import "GSFullscreenAd.h"

#define SCREEN_SIZE_IPHONE_CLASSIC 3.5
#define SCREEN_SIZE_IPHONE_TALL 4.0
#define SCREEN_SIZE_IPAD_CLASSIC 9.7

@interface iPadViewController : UIViewController <GSAdDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet GSLeaderboardAdView* myLeaderboardAd;
@property (nonatomic, retain) IBOutlet GSMediumRectangleAdView* myMediumRectangleAd;
@property (strong, nonatomic) GSFullscreenAd* myFullscreenAd;

@property (strong, nonatomic) IBOutlet UILabel* guidTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel* guidLabel;
@property (strong, nonatomic) IBOutlet UILabel* hashedIdLabel;
@property (strong, nonatomic) IBOutlet UILabel* sdkVersionLabel;
@property (strong, nonatomic) IBOutlet UILabel* statusLabel;
@property (strong, nonatomic) IBOutlet UIButton* leaderboardButton;
@property (strong, nonatomic) IBOutlet UIButton* mediumRectangleButton;
@property (strong, nonatomic) IBOutlet UIButton* fetchFullscreenButton;
@property (strong, nonatomic) IBOutlet UIButton* displayFullscreenButton;

//Button actions
- (IBAction)leaderboardButtonPressed:(id)sender;
- (IBAction)mediumRectangleButtonPressed:(id)sender;
- (IBAction)fetchFullscreenButtonPressed:(id)sender;
- (IBAction)displayFullscreenButtonPressed:(id)sender;
- (IBAction)openMail:(id)sender;

//Protocol methods for defining basic ad behaviors
- (UIViewController *)greystripeBannerDisplayViewController;
- (NSString *)greystripeGUID;
- (BOOL)greystripeBannerAutoload;

//Delegate "events" to be notified of ad lifecycle
- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad;
- (void)greystripeAdFetchFailed:(id<GSAd>)a_ad withError:(GSAdError)a_error;
- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad;
- (void)greystripeBannerAdWillExpand:(id<GSAd>)a_ad;
- (void)greystripeBannerAdDidCollapse:(id<GSAd>)a_ad;
- (void)greystripeWillPresentModalViewController;
- (void)greystripeDidDismissModalViewController;

@end