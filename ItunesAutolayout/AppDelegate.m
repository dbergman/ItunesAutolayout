//
//  AppDelegate.m
//  ItunesAutolayout
//
//  Created by Dustin Bergman on 11/4/14.
//  Copyright (c) 2014 Dustin Bergman. All rights reserved.
//

#import "AppDelegate.h"
#import "AlbumsAutoLayoutViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AlbumsAutoLayoutViewController *albumsViewController = [[AlbumsAutoLayoutViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:albumsViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
