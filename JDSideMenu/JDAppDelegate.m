//
//  SHAppDelegate.m
//  StatusBarTest
//
//  Created by Markus Emrich on 11/11/13.
//  Copyright (c) 2013 Markus Emrich. All rights reserved.
//

#import "JDAppDelegate.h"
#import "JDSideMenu.h"

@implementation JDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UIViewController *menu = [[UIViewController alloc] init];
    UIViewController *content = [[UIViewController alloc] init];
    menu.view.backgroundColor = [UIColor magentaColor];
    content.view.backgroundColor = [UIColor cyanColor];
    self.window.rootViewController = [[JDSideMenu alloc] initWithContentController:content
                                                                    menuController:menu];
    
    return YES;
}

@end
