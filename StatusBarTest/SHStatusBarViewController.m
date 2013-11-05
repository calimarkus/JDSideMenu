//
//  SHStatusBarViewController.m
//  StatusBarTest
//
//  Created by Simon Holroyd on 9/25/13.
//  Copyright (c) 2013 Simon Holroyd. All rights reserved.
//

#import "SHStatusBarViewController.h"

@interface SHStatusBarViewController ()
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *lastSnapShotView;
@end

@implementation SHStatusBarViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _containerView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_containerView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(showHideView:)]];
}

- (UIView *)snapShotView
{
    self.lastSnapShotView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
    return self.lastSnapShotView;
}

- (void)showHideView:(UITapGestureRecognizer*)recognizer
{
    if (self.containerView.frame.origin.x > 0) {
        [UIView animateWithDuration:0.4 animations:^{
            [self.containerView setFrame:self.containerView.bounds];
        } completion:^(BOOL finished) {
            self.statusBarHidden = NO;
            [self.lastSnapShotView removeFromSuperview];
            self.lastSnapShotView = nil;
        }];
    } else {
        [self.containerView addSubview:[self snapShotView]];
        self.statusBarHidden = YES;
        [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
            [self.containerView setFrame:CGRectOffset(self.containerView.bounds, 240.0, 0.0)];
        } completion:nil];
    }
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden;
{
    if (_statusBarHidden != statusBarHidden) {
        _statusBarHidden = statusBarHidden;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

@end
