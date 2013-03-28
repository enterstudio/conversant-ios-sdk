//
//  iPhoneMediumRectangleViewController.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSAdDelegate.h"

@class GSMediumRectangleAdView;

@interface iPhoneMediumRectangleViewController : UIViewController <GSAdDelegate>

@property (nonatomic, retain) IBOutlet GSMediumRectangleAdView* myMediumRectangleAd;

@property (strong, nonatomic) IBOutlet UILabel* statusLabel;
@property (strong, nonatomic) IBOutlet UIButton* mediumRectangleButton;

//Button actions
- (IBAction)mediumRectangleButtonPressed:(id)sender;

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

@end
