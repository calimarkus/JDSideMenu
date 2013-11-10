//
//  SHStatusBarViewController.m
//  StatusBarTest
//
//  Created by Simon Holroyd on 9/25/13.
//  Copyright (c) 2013 Simon Holroyd. All rights reserved.
//

#import "SHStatusBarViewController.h"

const CGFloat SHStatusBarDefaultMenuWidth = 260.0;

@interface SHStatusBarViewController ()
@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, strong) UIViewController *menuController;

@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *lastSnapShotView;
@end

@implementation SHStatusBarViewController

- (id)initWithContentController:(UIViewController*)contentController
                 menuController:(UIViewController*)menuController;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _contentController = contentController;
        _menuController = menuController;
        
        _menuWidth = SHStatusBarDefaultMenuWidth;
    }
    return self;
}

#pragma mark UIViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    // add childcontroller
    [self.menuController willMoveToParentViewController:self];
    [self addChildViewController:self.menuController];
    [self.menuController didMoveToParentViewController:self];
    [self.contentController willMoveToParentViewController:self];
    [self addChildViewController:self.contentController];
    [self.contentController didMoveToParentViewController:self];
    
    // add subviews
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:self.contentController.view];
    self.contentController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_containerView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(showHideView:)]];
}

#pragma mark Animation

- (void)showHideView:(UITapGestureRecognizer*)recognizer
{
    BOOL menuVisible = !CGAffineTransformEqualToTransform(self.containerView.transform, CGAffineTransformIdentity);
    
    // hide menu animation
    if (menuVisible) {
        __weak typeof(self) blockSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            blockSelf.containerView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [blockSelf.lastSnapShotView removeFromSuperview];
            [blockSelf.menuController.view removeFromSuperview];
            blockSelf.statusBarHidden = NO;
            blockSelf.lastSnapShotView = nil;
        }];
    }
    
    // show menu animation
    else {
        // add menu view
        CGRect menuFrame, restFrame;
        CGRectDivide(self.view.bounds, &menuFrame, &restFrame, self.menuWidth, CGRectMinXEdge);
        self.menuController.view.frame = menuFrame;
        self.menuController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.view.backgroundColor = self.menuController.view.backgroundColor;
        [self.view insertSubview:self.menuController.view atIndex:0];
        
        // add snapshotview, hide statusbar
        [self.containerView addSubview:[self snapShotView]];
        self.statusBarHidden = YES;
        
        // animate
        __weak typeof(self) blockSelf = self;
        [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
            blockSelf.containerView.transform = CGAffineTransformMakeTranslation(self.menuWidth, 0);
        } completion:nil];
    }
}

#pragma mark Status Bar State

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

#pragma mark Snapshot

- (UIView *)snapShotView
{
    self.lastSnapShotView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
    return self.lastSnapShotView;
}

@end
