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

@interface iPhoneMediumRectangleViewController : UIViewController <GSAdDelegate> {
    GSMediumRectangleAdView *myMediumRectangleAd;
}

@property (nonatomic, retain) IBOutlet UIButton *mediumRectangleButton;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

//Button actions
- (IBAction)mediumRectangleButtonPressed:(id)sender;

@end
