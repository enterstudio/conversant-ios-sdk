//
//  ViewController.swift
//  ConversantSDKSampleAppSwift
//
//  Created by Daniel Kanaan on 4/14/17.
//  Copyright © 2017 Daniel Kanaan. All rights reserved.
//

import UIKit
import ConversantSDK

class ViewController: UIViewController, ConversantInterstitialAdDelegate, ConversantBannerAdDelegate {
    
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var bannerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loadAd () {
        //Create an Interstitial Ad
        let interstitialAd = ConversantInterstitialAd(delegate: self)
        //Fetch the interstitial Ad
        interstitialAd.fetch()
        appendFeedback(text: "Fetching interstitial")
    }
    @IBAction func bannerAd(_ sender: UIButton) {
        ConversantConfiguration.defaultConfiguration.autoDisplay = false
        var adView:ConversantAdView!
        //Check if the ad already exists
        if let currentAd = view.viewWithTag(9) as? ConversantAdView {
            adView = currentAd
            if adView.isReady {
                adView.display()
                sender.setTitle("Fetch again", for: .normal)
                return
            }
        } else {
            //If there is no ad, create an ad
            adView = ConversantAdView(adFormat: .mobileBannerAd, delegate: self)
            //Add it to the view heirarchy
            view.addSubview(adView)
            //Give it a tag so we can get it later
            adView.tag = 9
        }
        //Set the frame of the ad to center below the button
        let newFrame = CGRect(x:sender.frame.origin.x + (sender.frame.width / 2) - (ConversantAdFormat.mobileBannerAd.width / 2), y:sender.frame.origin.y + sender.frame.height + 5, width: ConversantAdFormat.mobileBannerAd.width, height: ConversantAdFormat.mobileBannerAd.height)
        adView.frame = newFrame
        //fetch the ad
        adView.fetch()
        appendFeedback(text: "Fetching banner")
        //set the button to new text
        sender.setTitle("Display", for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Delegate function for successful load
    func interstitialAdLoadComplete(ad: ConversantInterstitialAd) {
        //Present the interstitial ad from this view controller
        ad.present(from: self)
        appendFeedback(text: "Interstitial Loaded")
    }
    
    //Delegate function for load failure.  Here we will present an Alert
    func interstitialAdLoadFailed(ad: ConversantInterstitialAd, error: ConversantError) {
        //Create a message using the error.description property
        let alert = UIAlertController(title: "Failed", message: "Ad Load Failed with error: \(error.description)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func bannerAdLoadComplete(ad: ConversantAdView) {
        appendFeedback(text: "Banner Loaded")
        if ad.isReady {
            ad.display()
            bannerButton.setTitle("Fetch again", for: .normal)
        } else {
            bannerButton.setTitle("Display", for:.normal)
        }
    }
    
    //Delegate function for banner load failure.  Here we will present an Alert
    func bannerAdLoadFailed(ad: ConversantAdView, error: ConversantError) {
        //Create a message using the error.description property
        let alert = UIAlertController(title: "Failed", message: "Ad Load Failed with error: \(error.description)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    //Other Delegate Functions
    func bannerAdWillPresentScreen(ad: ConversantAdView) {
        appendFeedback(text: "\(#function)")
    }
    
    func bannerAdDidDismissScreen(ad: ConversantAdView) {
        appendFeedback(text: "\(#function)")
    }
    func bannerAdWillDismissScreen(ad: ConversantAdView) {
        appendFeedback(text: "\(#function)")
    }
    func interstitialAdWillAppear(ad: ConversantInterstitialAd) {
        appendFeedback(text: "\(#function)")
    }
    func interstitialAdWillDisappear(ad: ConversantInterstitialAd) {
        appendFeedback(text: "\(#function)")
    }
    func interstitialAdDidDisappear(ad: ConversantInterstitialAd) {
        appendFeedback(text: "\(#function)")
    }
    //Helper functions
    
    func appendFeedback(text:String) {
        feedbackTextView.text = feedbackTextView.text +  text + "\n"
        let bottom = feedbackTextView.contentSize.height - feedbackTextView.bounds.size.height
        feedbackTextView.setContentOffset(CGPoint(x: 0, y: bottom), animated: true)
    }
}

