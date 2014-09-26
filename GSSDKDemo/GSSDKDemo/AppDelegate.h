//
//  AppDelegate.h
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GSAdDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) CLLocationManager *locationManager;

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

// Greystripe SDK Test App ID / GUID
#define GSGUID @"51d7ee3c-95fd-48d5-b648-c915209a00a5"

// For quick testing and debugging, paste your app's Greystripe GUID below in "appGUID"
// Comment out the #define line above and uncomment the #define line below
// Clean and build your project for testing and debugging
// #define GSGUID @"appGUID"

@end
