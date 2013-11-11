//
//  JDMenuViewController.m
//  JDSideMenu
//
//  Created by Markus Emrich on 11.11.13.
//  Copyright (c) 2013 Markus Emrich. All rights reserved.
//

#import "UIViewController+JDSideMenu.h"

#import "JDMenuViewController.h"

@interface JDMenuViewController ()

@end

@implementation JDMenuViewController

- (IBAction)switchController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithHue:(arc4random()%256/256.0)
                                                     saturation:1.0
                                                     brightness:1.0
                                                          alpha:1.0];
    
    [self.sideMenuController setContentController:viewController
                                          animted:YES];
}

@end
