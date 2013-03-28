//
//  iPhoneFullscreenViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPhoneFullscreenViewController.h"
#import "GSConstants.h"

@interface iPhoneFullscreenViewController ()

@end

@implementation iPhoneFullscreenViewController

@synthesize statusLabel, fetchFullscreenButton, displayFullscreenButton, myFullscreenAd;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Init my fullscren ad object, and set the delegate to be this ViewController
    self.myFullscreenAd = [[GSFullscreenAd alloc] initWithDelegate:self];
    
    self.statusLabel.text = @" ";
}

#pragma mark - Button methods

- (IBAction) fetchFullscreenButtonPressed:(id) sender {
    self.statusLabel.text = @"Fetching an ad...";
    [fetchFullscreenButton setEnabled:NO];
    
    // Fetch Fullscreen Ad
    [myFullscreenAd fetch];
}

- (IBAction) displayFullscreenButtonPressed:(id) sender {
    self.statusLabel.text = @"Display Fullscreen Ad.";
    
    // Display Fullscreen Ad
    [myFullscreenAd displayFromViewController:self];
    
    [displayFullscreenButton setEnabled:NO];
    [fetchFullscreenButton setEnabled:YES];
}

#pragma mark - Protocol methods

- (NSString *)greystripeGUID {
    NSLog(@"Accessing GUID");
    
    // The Greystripe GUID is defined in Constants.h and preloaded in GSSDKDemo-Prefix.pch in this example
    // Alternate example: You can also set the Greystripe GUID in the AppDelegate.m as well
    return GSGUID;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView resignFirstResponder];
}

- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad {
    if (a_ad == myFullscreenAd) {
        self.statusLabel.text = @"Fullscreen ad successfully fetched.";
        [displayFullscreenButton setEnabled:YES];
    }
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
    [fetchFullscreenButton setEnabled:YES];
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

@end
