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

@property (nonatomic, retain) GSFullscreenAd *myFullscreenAd;

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UIButton *fetchFullscreenButton;
@property (nonatomic, retain) IBOutlet UIButton *displayFullscreenButton;

//Button actions
- (IBAction)displayFullscreenButtonPressed:(id)sender;
- (IBAction)fetchFullscreenButtonPressed:(id)sender;

@end
