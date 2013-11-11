//
//  JDSideMenu.m
//  StatusBarTest
//
//  Created by Markus Emrich on 11/11/13.
//  Copyright (c) 2013 Markus Emrich. All rights reserved.
//

#import "JDSideMenu.h"

const CGFloat JDSideMenuDefaultMenuWidth = 260.0;
const CGFloat JDSideMenuDefaultDamping = 0.5;

const CGFloat JDSideMenuDefaultOpenAnimationTime = 1.2;
const CGFloat JDSideMenuDefaultCloseAnimationTime = 0.4;

@interface JDSideMenu ()
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *lastSnapShotView;
@end

@implementation JDSideMenu

- (id)initWithContentController:(UIViewController*)contentController
                 menuController:(UIViewController*)menuController;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _contentController = contentController;
        _menuController = menuController;
        
        _menuWidth = JDSideMenuDefaultMenuWidth;
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
    self.contentController.view.frame = self.containerView.bounds;
    self.contentController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_containerView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(showHideView:)]];
}

#pragma mark controller replacement

- (void)setContentController:(UIViewController*)contentController
                     animted:(BOOL)animated;
{
    if (self.contentController) {
        [self.contentController willMoveToParentViewController:nil];
        [self.contentController removeFromParentViewController];
        [self.contentController didMoveToParentViewController:nil];
        [self.contentController.view removeFromSuperview];
    }
    
    _contentController = contentController;
    
    // add childcontroller
    [self.contentController willMoveToParentViewController:self];
    [self addChildViewController:self.contentController];
    [self.contentController didMoveToParentViewController:self];
    
    // add subview
    [self.containerView addSubview:self.contentController.view];
    self.contentController.view.frame = self.containerView.bounds;
    self.contentController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark Animation

- (void)showHideView:(UITapGestureRecognizer*)recognizer
{
    if (![self isMenuVisible]) {
        [self showMenuAnimated:YES];
    } else {
        [self hideMenuAnimated:YES];
    }
}

- (void)showMenuAnimated:(BOOL)animated;
{
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
    [UIView animateWithDuration:animated ? JDSideMenuDefaultOpenAnimationTime : 0.0 delay:0 usingSpringWithDamping:JDSideMenuDefaultDamping initialSpringVelocity:1.0 options:0 animations:^{
        blockSelf.containerView.transform = CGAffineTransformMakeTranslation(self.menuWidth, 0);
    } completion:nil];
}

- (void)hideMenuAnimated:(BOOL)animated;
{
    __weak typeof(self) blockSelf = self;
    [UIView animateWithDuration:JDSideMenuDefaultCloseAnimationTime animations:^{
        blockSelf.containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [blockSelf.lastSnapShotView removeFromSuperview];
        [blockSelf.menuController.view removeFromSuperview];
        blockSelf.statusBarHidden = NO;
        blockSelf.lastSnapShotView = nil;
    }];
}

#pragma mark State

- (BOOL)isMenuVisible;
{
    return !CGAffineTransformEqualToTransform(self.containerView.transform,
                                              CGAffineTransformIdentity);
}

#pragma mark Status Bar

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
