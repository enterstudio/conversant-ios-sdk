//
//  AppDelegate.m
//  GSSDKDemo
//
//  Created by Jeffrey Carlson on 9/16/12.
//  Copyright (c) 2012 Greystripe. All rights reserved.
//

#import "AppDelegate.h"

#import "GSSDKInfo.h"

@implementation AppDelegate

@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Globally set the Greystripe GUID
    [GSSDKInfo setGUID:GSGUID];
    
    // To pass location information to the Greystripe SDK, initialize CLLocationManager.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startMonitoringSignificantLocationChanges];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

// Greystripe strongly recommends setting interface orientation on a per view controller basis
// Greystripe's SDK supports rotation and any orientation on iOS devices

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Use the call below to pass your location to the Greystripe SDK
    [GSSDKInfo updateLocation:newLocation];
    
    //Use the NSLogs below to see Location information in real time
    
    //NSLog(@"%@", newLocation);
    //NSLog(@"Lat: %f", newLocation.coordinate.latitude);
    //NSLog(@"Long: %f", newLocation.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //NSLog(@"updateLocation failed.");
}

@end
