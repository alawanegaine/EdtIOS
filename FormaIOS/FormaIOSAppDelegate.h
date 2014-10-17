//
//  FormaIOSAppDelegate.h
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreferencesManager.h"
#import "Reachability.h"

@interface FormaIOSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PreferencesManager *prefsManager ;
@property (nonatomic) NetworkStatus networkStatus ;

- (void)afficherErreurConnexion ;

@end
