//
//  AvidManagedVideoAdSession.h
//  AppVerificationLibrary
//
//  Created by Daria Sukhonosova on 05/04/16.
//  Copyright © 2016 Integral. All rights reserved.
//

#import "Conversant_AbstractAvidManagedAdSession.h"
#import "Conversant_AvidVideoPlaybackListener.h"

@interface Conversant_AvidManagedVideoAdSession : Conversant_AbstractAvidManagedAdSession

@property(nonatomic, readonly) id<Conversant_AvidVideoPlaybackListener> avidVideoPlaybackListener;

@end
