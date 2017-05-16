//
//  ViewController.m
//  ConversantSDKSampleAppObjC
//
//  Created by Daniel Kanaan on 4/14/17.
//  Copyright © 2017 Daniel Kanaan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UIButton *bannerAdButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loadAd:(id)sender {
    ConversantInterstitialAd *ad = [[ConversantInterstitialAd alloc] initWithDelegate: self];
    [ad fetch];
    [self appendFeedback: @"Fetching interstitial"];
}
- (IBAction) bannerAd: (UIButton*) sender {
    ConversantConfiguration.defaultConfiguration.autoDisplay = false;
    ConversantAdView * adView;
    //Check if the ad already exists
    adView = (ConversantAdView *)[self.view viewWithTag:9];
    if (adView != NULL) {
        if (adView.isReady) {
            [adView display];
            [sender setTitle:@"Fetch Again" forState:UIControlStateNormal];
            return;
        }
    } else {
        //If there is no ad, create an ad
        adView = [[ConversantAdView alloc] initWithAdFormat:ConversantAdFormatMobileBannerAd delegate: self];
        //Add it to the view heirarchy
        [self.view addSubview:adView];
        //Give it a tag so we can get it later
        [adView setTag:9];
    }
    //Set the frame of the ad to center below the button
    CGRect  newFrame = CGRectMake(sender.frame.origin.x + (sender.frame.size.width / 2) - (320 / 2), sender.frame.origin.y + sender.frame.size.height + 5, 320, 50 );
    [adView setFrame:newFrame];
    //fetch the ad
    [adView fetch];
    [self appendFeedback:@"Fetching banner"];
    //set the button to new text
    [sender setTitle:@"Display" forState:UIControlStateNormal];
}

//Delegate function for load failure.  Here we will present an Alert
- (void)interstitialAdLoadFailedWithAd:(ConversantInterstitialAd *)ad error:(ConversantError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:[NSString stringWithFormat:@"Loading failed with error %@", error.description] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:NULL];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion: nil];
}
//Delegate function for banner load failure.  Here we will present an Alert
- (void)bannerAdLoadFailedWithAd:(ConversantAdView *)ad error:(ConversantError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops" message:[NSString stringWithFormat:@"Loading failed with error %@", error.description] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:NULL];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion: nil];
}

//Delegate function for successful load
- (void)interstitialAdLoadCompleteWithAd:(ConversantInterstitialAd *)ad {
    [ad presentFrom:self];
    [self appendFeedback:@"Interstitial Loaded"];
}

- (void)bannerAdLoadCompleteWithAd:(ConversantAdView *)ad {
    [self appendFeedback:@"Banner Loaded"];
    if (ad.isReady) {
        [ad display];
        [_bannerAdButton setTitle:@"Fetch again" forState: UIControlStateNormal];
    } else {
        [_bannerAdButton setTitle:@"Display" forState:UIControlStateNormal];
    }
   // [ad setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.view.bounds.size.height - 50, ad.frame.size.width, ad.frame.size.height)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Helper functions

- (void) appendFeedback: (NSString * ) text {
    [self.feedbackTextView setText:[[self.feedbackTextView.text stringByAppendingString: text] stringByAppendingString:@"\n"]];
    double bottom = self.feedbackTextView.contentSize.height - self.feedbackTextView.bounds.size.height;
    [self.feedbackTextView setContentOffset:CGPointMake(0, bottom) animated: YES];
}


//Other Delegate Functions
- (void)bannerAdWillPresentScreenWithAd:(ConversantAdView *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}
- (void)bannerAdDidDismissScreenWithAd:(ConversantAdView *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}
- (void)bannerAdWillDismissScreenWithAd:(ConversantAdView *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}
- (void)interstitialAdWillAppearWithAd:(ConversantInterstitialAd *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}
- (void)interstitialAdWillDisappearWithAd:(ConversantInterstitialAd *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}
- (void)interstitialAdDidDisappearWithAd:(ConversantInterstitialAd *)ad {
    [self appendFeedback:NSStringFromSelector(_cmd)];
}



@end
