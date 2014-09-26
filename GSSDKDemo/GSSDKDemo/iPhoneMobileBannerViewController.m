//
//  iPhoneMobileBannerViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPhoneMobileBannerViewController.h"

#import "GSAdDelegate.h"
#import "GSMobileBannerAdView.h"
#import "GSSDKInfo.h"

@interface iPhoneMobileBannerViewController () <GSAdDelegate>

@property (nonatomic, strong) GSMobileBannerAdView *myBannerAd;
@property (nonatomic, weak) IBOutlet UIButton *bannerButton;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@end

@implementation iPhoneMobileBannerViewController

#pragma mark - UIViewController -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myBannerAd = [[GSMobileBannerAdView alloc] initWithDelegate:self];
    
    [self.myBannerAd setFrame:CGRectMake(0, 20, kGSMobileBannerWidth, kGSMobileBannerHeight)];
}

#pragma mark - Greystripe UIViewController -

- (UIViewController *)greystripeBannerDisplayViewController
{
    return self;
}

#pragma mark - IBAction Button -

- (IBAction)bannerButtonPressed:(id)sender
{
    self.statusLabel.text = @"Fetching an ad...";
    [self.bannerButton setEnabled:NO];
    
    // Fetch Banner Ad
    [self.myBannerAd fetch];
}

#pragma mark - Greystripe Protocol Methods -

- (BOOL)greystripeBannerAutoload
{
    // Return TRUE to autoload an ad
    return FALSE;
}

- (BOOL)greystripeShouldLogAdID
{
    // Return TRUE to log the AdID in an NSLog. Useful for debugging purposes
    return FALSE;
}

- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad
{
    if (a_ad == self.myBannerAd)
    {
        [self.view addSubview:self.myBannerAd];
        
        self.statusLabel.text = @"Small banner successfully fetched.";

        [self.bannerButton setEnabled:YES];
    }
    
    // Use the a_ad object to return the adID value for debugging purposes
    NSString *gsAdId = [a_ad adID];
    NSLog(@"AdId NSString Value: %@", gsAdId);
}

- (void)greystripeAdFetchFailed:(id<GSAd>)a_ad withError:(GSAdError)a_error
{
    NSString *errorString =  @"";
    
    switch(a_error)
    {
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
    [self.bannerButton setEnabled:YES];
}

- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad
{
    self.statusLabel.text = @"Greystripe ad was clicked.";
}

- (void)greystripeBannerWillExpand:(id<GSAd>)a_ad
{
    self.statusLabel.text = @"Greystripe ad expanded.";
}

- (void)greystripeBannerDidCollapse:(id<GSAd>)a_ad
{
    self.statusLabel.text = @"Greystripe ad collapsed.";
}

#pragma mark - Banner Rotation Management -

- (void) viewWillLayoutSubviews
{
    [self.myBannerAd setFrame:CGRectMake(([self.view bounds].size.width - kGSMobileBannerWidth)/2, 20, kGSMobileBannerWidth, kGSMobileBannerHeight)];
}

#pragma mark - Memory Management -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
