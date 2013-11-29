//
//  SHAppDelegate.m
//  StatusBarTest
//
//  Created by Markus Emrich on 11/11/13.
//  Copyright (c) 2013 Markus Emrich. All rights reserved.
//

#import "JDSideMenu.h"
#import "JDMenuViewController.h"

#import "JDAppDelegate.h"

@implementation JDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UIViewController *menuController = [[JDMenuViewController alloc] init];
    UIViewController *contentController = [[UIViewController alloc] init];
    contentController.view.backgroundColor = [UIColor colorWithHue:0.5 saturation:1.0 brightness:1.0 alpha:1.0];
    contentController.title = [NSString stringWithFormat: @"Hue: %.2f", 0.5];
    
    UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:contentController];
    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:navController
                                                          menuController:menuController];
    [sideMenu setBackgroundImage:[UIImage imageNamed:@"menuwallpaper"]];
    self.window.rootViewController = sideMenu;
    
    return YES;
}

@end
