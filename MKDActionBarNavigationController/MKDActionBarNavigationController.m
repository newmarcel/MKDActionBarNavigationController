//
//  MKDActionBarNavigationController.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 14.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDActionBarNavigationController.h"
#import "MKDActionBar.h"

#define Auto __auto_type
#define kAnimationDuration (NSTimeInterval)0.3f

typedef UIViewController<MKDActionButtonHosting> *MKDActionsViewController;

@interface MKDActionBarNavigationController () <UINavigationControllerDelegate>
@property (nonatomic, nullable) MKDActionBar *actionBar;
@end

NS_INLINE BOOL MKDViewControllerSupportsActionButtonHosting(UIViewController *vc)
{
    Auto hostVC = (MKDActionsViewController)vc;
    return [vc conformsToProtocol:@protocol(MKDActionButtonHosting)] && hostVC.actionBarButtonItems.count > 0;
}

@implementation MKDActionBarNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureActionButtonBar];
    
    self.delegate = self;
}

#pragma mark - Configure Action Button

- (UIButton *)configuredActionButtonForStyle:(MKDActionButtonItemStyle)style
{
    Auto button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2];
    
    switch(style)
    {
        case MKDActionButtonItemStylePrimary:
            break;
        case MKDActionButtonItemStyleSecondary:
//            button.tintColor = [UIColor colorWithRed:0.941 green:0.347 blue:0.459 alpha:1.000];
            button.tintColor = [UIColor colorWithWhite:0.74f alpha:1.0f];
//            button.tintColor = [UIColor colorWithWhite:0.851 alpha:1.000];
//            [button setTitleColor:[UIColor colorWithWhite:0.56f alpha:1.0f] forState:UIControlStateNormal];
            break;
    }
    
    return button;
}

#pragma mark -

- (void)configureActionButtonBar
{
    Auto bar = [[MKDActionBar alloc] initWithFrame:CGRectZero];
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    bar.hidden = YES;
    [self.view addSubview:bar];
    self.actionBar = bar;
    
    __weak typeof(self) weakSelf = self;
    bar.buttonFactory = ^UIButton *(MKDActionButtonItemStyle style) {
        return [weakSelf configuredActionButtonForStyle:style];
    };
    
    Auto constraints = @[
                         [self.actionBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                         [self.actionBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                         [self.actionBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
                         ];
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark -

- (void)updateVisibilityForActionButtons
{
    if([self.topViewController conformsToProtocol:@protocol(MKDActionButtonHosting)])
    {
        [self configureActionButtonsForViewController:(MKDActionsViewController)self.topViewController];
        [self showBarAnimated:NO];
    }
    else
    {
        [self disableActionButtons];
    }
}

- (void)configureActionButtonsForViewController:(MKDActionsViewController)viewController
{
    NSArray<MKDActionButtonItem *> *items = [viewController.actionBarButtonItems copy];
    [self.actionBar configureWithActionButtonItems:items];
}

- (void)disableActionButtons
{
    [self disableActionButtonsAnimated:NO];
}

- (void)disableActionButtonsAnimated:(BOOL)animated
{
    [self hideBarAnimated:animated];
}

#pragma mark - Hide / Show Bar

- (void)showBarAnimated:(BOOL)animated
{
    if(animated)
    {
        if(self.actionBar.alpha < 1.0f)
        {
            self.actionBar.alpha = 0.0f;
            self.actionBar.hidden = NO;
        }
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.actionBar.alpha = 1.0f;
        }];
        
    }
    else
    {
        self.actionBar.hidden = NO;
    }
    
}

- (void)hideBarAnimated:(BOOL)animated
{
    if(animated)
    {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.actionBar.hidden = NO;
            self.actionBar.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.actionBar.hidden = YES;
        }];
    }
    else
    {
        self.actionBar.hidden = YES;
    }
}

#pragma mark - Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.actionBar.userInteractionEnabled = NO;
    
    if(MKDViewControllerSupportsActionButtonHosting(viewController))
    {
        if(!animated)
        {
            [self configureActionButtonsForViewController:(MKDActionsViewController)viewController];
            [self showBarAnimated:animated];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.actionBar.userInteractionEnabled = YES;
    
    if(MKDViewControllerSupportsActionButtonHosting(viewController))
    {
        if(animated)
        {
            [self configureActionButtonsForViewController:(MKDActionsViewController)viewController];
            [self showBarAnimated:animated];
        }
        
        CGFloat inset = self.actionBar.bounds.size.height - self.actionBar.safeAreaInsets.bottom;
        viewController.additionalSafeAreaInsets = UIEdgeInsetsMake(0.0f, 0.0f, inset, 0.0f);
    }
    else
    {
        if(animated)
        {
            [self disableActionButtonsAnimated:animated];
        }
        viewController.additionalSafeAreaInsets = UIEdgeInsetsZero;
    }
}

#pragma mark - Changes

- (void)setNeedsActionButtonUpdate
{
    Auto viewController = self.topViewController;
    [self handleItemChangeForViewController:viewController animated:YES];
}

- (void)actionButtonItemsDidChange
{
    [self setNeedsActionButtonUpdate];
}

- (void)handleItemChangeForViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSParameterAssert(viewController);
    
    self.actionBar.userInteractionEnabled = NO;
    
    if(MKDViewControllerSupportsActionButtonHosting(viewController))
    {
        [self configureActionButtonsForViewController:(MKDActionsViewController)viewController];
        [self showBarAnimated:animated];
        
        CGFloat inset = self.actionBar.bounds.size.height - self.actionBar.safeAreaInsets.bottom;
        viewController.additionalSafeAreaInsets = UIEdgeInsetsMake(0.0f, 0.0f, inset, 0.0f);
    }
    else
    {
        if(animated)
        {
            [self disableActionButtonsAnimated:animated];
        }
        viewController.additionalSafeAreaInsets = UIEdgeInsetsZero;
    }
    
    self.actionBar.userInteractionEnabled = YES;
}

@end
