//
//  iPhoneMobileBannerViewController.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSAdDelegate.h"

@class GSMobileBannerAdView;

@interface iPhoneMobileBannerViewController : UIViewController <GSAdDelegate> {
    GSMobileBannerAdView *myBannerAd;
}

@property (nonatomic, retain) IBOutlet UIButton *bannerButton;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

//Button actions
- (IBAction)bannerButtonPressed:(id)sender;

@end
