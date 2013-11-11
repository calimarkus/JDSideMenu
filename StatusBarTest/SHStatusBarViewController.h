//
//  SHStatusBarViewController.h
//  StatusBarTest
//
//  Created by Simon Holroyd on 9/25/13.
//  Copyright (c) 2013 Simon Holroyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHStatusBarViewController : UIViewController

@property (nonatomic, readonly) UIViewController *contentController;
@property (nonatomic, readonly) UIViewController *menuController;

@property (nonatomic, assign) CGFloat menuWidth;

- (id)initWithContentController:(UIViewController*)contentController
                 menuController:(UIViewController*)menuController;

- (void)setContentController:(UIViewController*)contentController
                     animted:(BOOL)animated;

- (void)showMenuAnimated:(BOOL)animated;
- (void)hideMenuAnimated:(BOOL)animated;

- (BOOL)isMenuVisible;

@end
