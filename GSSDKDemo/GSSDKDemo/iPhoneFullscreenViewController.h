//
//  iPhoneFullscreenViewController.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSAdDelegate.h"

@class GSFullscreenAd;

@interface iPhoneFullscreenViewController : UIViewController <GSAdDelegate>

@property (strong, nonatomic) GSFullscreenAd* myFullscreenAd;

@property (strong, nonatomic) IBOutlet UILabel* statusLabel;
@property (strong, nonatomic) IBOutlet UIButton* fetchFullscreenButton;
@property (strong, nonatomic) IBOutlet UIButton* displayFullscreenButton;

//Button actions
- (IBAction)fetchFullscreenButtonPressed:(id)sender;
- (IBAction)displayFullscreenButtonPressed:(id)sender;

//Protocol methods for defining basic ad behaviors
- (NSString *)greystripeGUID;

//Delegate "events" to be notified of ad lifecycle
- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad;
- (void)greystripeAdFetchFailed:(id<GSAd>)a_ad withError:(GSAdError)a_error;
- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad;
- (void)greystripeWillPresentModalViewController;
- (void)greystripeDidDismissModalViewController;

@end
