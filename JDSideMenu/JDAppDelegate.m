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
    
    UIViewController *menu = [[JDMenuViewController alloc] init];
    UIViewController *content = [[UIViewController alloc] init];
    content.view.backgroundColor = [UIColor cyanColor];
    self.window.rootViewController = [[JDSideMenu alloc] initWithContentController:content
                                                                    menuController:menu];
    
    return YES;
}

@end
