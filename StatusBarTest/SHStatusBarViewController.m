//
//  SHStatusBarViewController.m
//  StatusBarTest
//
//  Created by Simon Holroyd on 9/25/13.
//  Copyright (c) 2013 Simon Holroyd. All rights reserved.
//

#import "SHStatusBarViewController.h"

@interface SHStatusBarViewController ()

@property (nonatomic, assign) BOOL hideStatusBar;
@property (nonatomic, strong) UIView *container;

@end

@implementation SHStatusBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        _hideStatusBar = NO;

        _container = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_container];


        self.view.backgroundColor = [UIColor redColor];

        [self performSelector:@selector(doSlideOut) withObject:nil afterDelay:2.0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)getSnapShot
{
    return [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
}

- (void)doSlideOut
{

    [self.container addSubview:[self getSnapShot]];
    self.hideStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        [self.container setFrame:(CGRect){
                200,
                0,
                self.container.frame.size
        }];
    }];

}


- (BOOL)prefersStatusBarHidden
{
    return self.hideStatusBar;
}

@end
