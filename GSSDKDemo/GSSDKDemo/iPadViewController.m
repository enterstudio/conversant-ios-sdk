//
//  iPadViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPadViewController.h"

#import "GSSDKInfo.h"

@interface iPadViewController ()

@end

@implementation iPadViewController

@synthesize guidTitleLabel, guidLabel, hashedIdLabel, sdkVersionLabel, statusLabel, leaderboardButton, mediumRectangleButton, myMediumRectangleAd, myLeaderboardAd, myFullscreenAd, fetchFullscreenButton, displayFullscreenButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //Grab the Greystripe GUID and add to label
    self.guidLabel.text = GSGUID;
    
    //Labels the Test GUID
    NSString *testGSGUID = [NSString stringWithFormat:@"51d7ee3c-95fd-48d5-b648-c915209a00a5"];
    if( [GSGUID isEqualToString:testGSGUID] ) {
        self.guidTitleLabel.text = [NSString stringWithFormat:@"Greystripe Test GUID"];
    }
    
    //Put an initial status into the status box
    self.hashedIdLabel.text = [GSSDKInfo hashedDeviceId];
    
    //Populate SDK version and GS Device ID labels
    self.sdkVersionLabel.text = [NSString stringWithFormat:@"iOS %@", kGSSDKVersion];

    //Init my fullscren ad object, and set the delegate to be this ViewController
    self.myFullscreenAd = [[GSFullscreenAd alloc] initWithDelegate:self];
}

#pragma mark - Button methods

- (IBAction) mediumRectangleButtonPressed:(id) sender {
    self.statusLabel.text = @"Fetching an ad...";
    [mediumRectangleButton setEnabled:NO];

    // Fetch Medium Rectangle Ad
    [myMediumRectangleAd fetch];
}

- (IBAction)leaderboardButtonPressed: (id) sender {
    self.statusLabel.text = @"Fetching an ad...";
    [leaderboardButton setEnabled:NO];

    // Fetch Leaderboard Ad
    [myLeaderboardAd fetch];
}

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

- (void)greystripeAdFetchSucceeded:(id<GSAd>)a_ad {
    if (a_ad == myLeaderboardAd) {
        self.statusLabel.text = @"Leaderboard successfully fetched.";
        [leaderboardButton setEnabled:YES];
    } else if (a_ad == myMediumRectangleAd) {
        self.statusLabel.text = @"Medium Rectangle Ad successfully fetched.";
        [mediumRectangleButton setEnabled:YES];
    } else if (a_ad == myFullscreenAd) {
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
    [mediumRectangleButton setEnabled:YES];
    [fetchFullscreenButton setEnabled:YES];
    [leaderboardButton setEnabled:YES];
}

- (void)greystripeAdClickedThrough:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad was clicked.";
}
- (void)greystripeBannerAdWillExpand:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad expanded.";
}
- (void)greystripeBannerAdDidCollapse:(id<GSAd>)a_ad {
    self.statusLabel.text = @"Greystripe ad collapsed.";
}

- (void)greystripeWillPresentModalViewController {
    self.statusLabel.text = @"Greystripe opening fullscreen.";
}

- (void)greystripeDidDismissModalViewController {
    self.statusLabel.text = @"Greystripe closed fullscreen.";
}

- (IBAction)openMail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Greystripe iOS %@ SDK Info", kGSSDKVersion]];
        NSString *emailBody = [NSString stringWithFormat:@"<p><b>Hashed Device Id:</b> %@ </p><p><b>Greystripe SDK Version:</b> iOS %@</p><p><b>Greystripe GUID:</b> %@</p><p><b>Documentation Resources:</b> <a href=\"http://wiki.greystripe.com\">http://wiki.greystripe.com</a></p><p><b>Questions? Contact GS Support:</b> <a href=\"mailto:support@greystripe.com\">support@greystripe.com</a></p>", [GSSDKInfo hashedDeviceId], kGSSDKVersion, GSGUID];
        [mailer setMessageBody:emailBody isHTML:YES];
        //mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentModalViewController:mailer animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
        message:@"Your device doesn't support the composer sheet"
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}

@end
