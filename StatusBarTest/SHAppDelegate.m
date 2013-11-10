//
//  SHAppDelegate.m
//  StatusBarTest
//
//  Created by Simon Holroyd on 9/25/13.
//  Copyright (c) 2013 Simon Holroyd. All rights reserved.
//

#import "SHAppDelegate.h"
#import "SHStatusBarViewController.h"

@implementation SHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UIViewController *menu = [[UIViewController alloc] init];
    UIViewController *content = [[UIViewController alloc] init];
    menu.view.backgroundColor = [UIColor magentaColor];
    content.view.backgroundColor = [UIColor cyanColor];
    self.window.rootViewController = [[SHStatusBarViewController alloc] initWithContentController:content
                                                                                   menuController:menu];
    
    return YES;
}

@end
