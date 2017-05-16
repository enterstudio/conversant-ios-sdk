//
//  AvidAdSessionManager.h
//  AppVerificationLibrary
//
//  Created by Daria Sukhonosova on 05/04/16.
//  Copyright © 2016 Integral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Conversant_AvidDisplayAdSession.h"
#import "Conversant_AvidManagedDisplayAdSession.h"
#import "Conversant_AvidVideoAdSession.h"
#import "Conversant_AvidManagedVideoAdSession.h"
#import "Conversant_ExternalAvidAdSessionContext.h"

@interface Conversant_AvidAdSessionManager : NSObject

+ (NSString *)version;
+ (NSString *)releaseDate;

+ (Conversant_AvidVideoAdSession *)startAvidVideoAdSessionWithContext:(Conversant_ExternalAvidAdSessionContext *)avidAdSessionContext;
+ (Conversant_AvidDisplayAdSession *)startAvidDisplayAdSessionWithContext:(Conversant_ExternalAvidAdSessionContext *)avidAdSessionContext;
+ (Conversant_AvidManagedVideoAdSession *)startAvidManagedVideoAdSessionWithContext:(Conversant_ExternalAvidAdSessionContext *)avidAdSessionContext;
+ (Conversant_AvidManagedDisplayAdSession *)startAvidManagedDisplayAdSessionWithContext:(Conversant_ExternalAvidAdSessionContext *)avidAdSessionContext;

@end
