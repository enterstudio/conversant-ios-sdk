//
//  iPhoneInfoViewController.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "iPhoneInfoViewController.h"

#import "GSSDKInfo.h"

@interface iPhoneInfoViewController ()

@end

@implementation iPhoneInfoViewController

@synthesize guidTitleLabel, guidLabel, hashedIdLabel, sdkVersionLabel;

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
}

- (IBAction)openMail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Greystripe iOS %@ SDK Info", kGSSDKVersion]];
        NSString *emailBody = [NSString stringWithFormat:@"<p><b>Hashed Device Id:</b> %@ </p><p><b>Greystripe SDK Version:</b> iOS %@</p><p><b>Greystripe GUID:</b> %@</p><p><b>Documentation Resources:</b> <a href=\"http://wiki.greystripe.com\">http://wiki.greystripe.com</a></p><p><b>Questions? Contact GS Support:</b> <a href=\"mailto:support@greystripe.com\">support@greystripe.com</a></p>", [GSSDKInfo hashedDeviceId], kGSSDKVersion, GSGUID];
        [mailer setMessageBody:emailBody isHTML:YES];
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
