//
//  AppDelegate.m
//  PhotoSubmitterExample
//
//  Created by Kentaro ISHITOYA on 12/03/06.
//  Copyright (c) 2012 Kentaro ISHITOYA. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize mainViewController = _mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    _mainViewController = [[MainViewController alloc] init];
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

/*!
 * OAuth delegate
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PhotoSubmitterManager sharedInstance] didOpenURL:url];
}

@end
