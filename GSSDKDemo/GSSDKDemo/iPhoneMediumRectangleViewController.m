//
//  iPhoneMediumRectangleViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPhoneMediumRectangleViewController.h"

#import "GSMediumRectangleAdView.h"
#import "GSSDKInfo.h"

@interface iPhoneMediumRectangleViewController ()

@end

@implementation iPhoneMediumRectangleViewController

@synthesize statusLabel, mediumRectangleButton, myMediumRectangleAd;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Button methods

- (IBAction) mediumRectangleButtonPressed:(id) sender {
    self.statusLabel.text = @"Fetching an ad...";
    [mediumRectangleButton setEnabled:NO];
    
    //Fetch Medium Rectangle Ad
    [myMediumRectangleAd fetch];
}

#pragma mark - Protocol methods

- (UIViewController *)greystripeBannerDisplayViewController
{
    return self;
}

- (NSString *)greystripeGUID {
    NSLog(@"Accessing GUID");
    
    // The Greystripe GUID is defined in Constants.h and preloaded in GSSDKDemo-Prefix.pch in this example
    // Alternate example: You can also set the Greystripe GUID in the AppDelegate.m as well
    return GSGUID;
}

- (BOOL)greystripeBannerAutoload {
    return TRUE;
}

- (BOOL)greystripeShouldLogAdID {
    
    // Return TRUE to log the AdID in an NSLog. Useful for debugging purposes.
    return FALSE;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView resignFirstResponder];
}
- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad {
    if (a_ad == myMediumRectangleAd) {
        self.statusLabel.text = @"Medium Rectangle Ad successfully fetched.";
        [mediumRectangleButton setEnabled:YES];
    }
    
    // Use the a_ad object to return the adID value for debugging purposes
    NSString *gsAdId = [a_ad adID];
    NSLog(@"AdId NSString Value: %@", gsAdId);
}

- (void)greystripeAdFetchFailed:(id<GSAd>)a_ad withError:(GSAdError)a_error {
    NSString *errorString =  @"";
    
    switch(a_error) {
        case kGSNoNetwork:
            errorString = @"Error: No network connection available.";
            break;
        case kGSNoAd:
            errorString = @"Error: No ad available from server.";
            break;
        case kGSTimeout:
            errorString = @"Error: Fetch request timed out.";
            break;
        case kGSServerError:
            errorString = @"Error: Greystripe returned a server error.";
            break;
        case kGSInvalidApplicationIdentifier:
            errorString = @"Error: Invalid or missing application identifier.";
            break;
        case kGSAdExpired:
            errorString = @"Error: Previously fetched ad expired.";
            break;
        case kGSFetchLimitExceeded:
            errorString = @"Error: Too many requests too quickly.";
            break;
        case kGSUnknown:
            errorString = @"Error: An unknown error has occurred.";
            break;
        default:
            errorString = @"An invalid error code was returned. Thats really bad!";
    }
    self.statusLabel.text = [NSString stringWithFormat:@"Greystripe failed with error: %@",errorString];
    [mediumRectangleButton setEnabled:YES];
}

- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad was clicked.";
}
- (void)greystripeWillPresentModalViewController {
    self.statusLabel.text = @"Greystripe opening fullscreen.";
}
- (void)greystripeDidDismissModalViewController {
    self.statusLabel.text = @"Greystripe closed fullscreen.";
}
- (void)greystripeBannerAdWillExpand:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad expanded.";
}
- (void)greystripeBannerAdDidCollapse:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad collapsed.";
}

@end