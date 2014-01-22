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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)switchController:(id)sender;
@end

@implementation JDMenuViewController

- (void)viewDidLayoutSubviews;
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGRectInset(self.scrollView.bounds, 0, -1).size;
}

- (IBAction)switchController:(id)sender;
{
    CGFloat randomHue = (arc4random()%256/256.0);
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithHue:randomHue saturation:1.0 brightness:1.0 alpha:1.0];
    viewController.title = [NSString stringWithFormat: @"Hue: %.2f", randomHue];
    
    UIViewController *contentController = [[UINavigationController alloc]
                                           initWithRootViewController:viewController];
    [self.sideMenuController setContentController:contentController animated:YES];
}

@end
