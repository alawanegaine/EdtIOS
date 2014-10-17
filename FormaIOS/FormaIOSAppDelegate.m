//
//  FormaIOSAppDelegate.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 08/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "FormaIOSAppDelegate.h"

@interface FormaIOSAppDelegate ()

@property (readonly, nonatomic) Reachability *reacher ;

@end

@implementation FormaIOSAppDelegate

@synthesize prefsManager = _prefsManager ;
@synthesize reacher = _reacher ;

- (Reachability*)reacher {
    if (_reacher == nil) {
        _reacher = [Reachability reachabilityForInternetConnection] ;
    }
    return _reacher ;
}

- (NetworkStatus)networkStatus {
    return [self.reacher currentReachabilityStatus] ;
}

- (PreferencesManager*)prefsManager {
    if (_prefsManager == nil) {
        _prefsManager = [[PreferencesManager alloc] init] ;
    }
    return _prefsManager ;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"init des pref : %d", self.prefsManager.initOK) ;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)afficherErreurConnexion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"La connexion internet est indisponnible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
    [alert show] ;
}

@end
