//
//  MKDActionBar.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 15.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDActionBar.h"

#define kBottomBarHeight 88.0f
#define kPixel (CGFloat)(1.0f / UIScreen.mainScreen.scale)

@interface MKDActionBar ()
@property (nonatomic, readwrite) UIVisualEffectView *visualEffectView;
@property (nonatomic, readwrite) UIStackView *buttonStackView;
@end

@implementation MKDActionBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self configureVisualEffectView];
        [self configureStackView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self configureVisualEffectView];
    [self configureStackView];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    UIColor *separatorColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    [separatorColor set];
    
    CGRect lineRect = CGRectMake(0.0f, 0.0f, rect.size.width, kPixel);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), lineRect);
}

- (void)configureVisualEffectView
{
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    self.visualEffectView = view;
    
    id constraints = @[
                       [view.topAnchor constraintEqualToAnchor:self.topAnchor constant:kPixel],
                       [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                       [view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                       [view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]
                       ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configureStackView
{
    if(@available(iOS 12.0, *)) {} else
    {
        self.backgroundColor = UIColor.clearColor;
    }
    
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    stack.alignment = UIStackViewAlignmentFirstBaseline;
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.distribution = UIStackViewDistributionFillEqually;
    stack.spacing = UIStackViewSpacingUseSystem;
    stack.baselineRelativeArrangement = YES;
    
    [self.visualEffectView.contentView addSubview:stack];
    self.buttonStackView = stack;
    
    UIView *parent = self.visualEffectView.contentView;
    
    NSLayoutConstraint *safeAreaBottom = [stack.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor];
    safeAreaBottom.priority = UILayoutPriorityDefaultLow;
    
    id constraints = @[
                       [stack.topAnchor constraintEqualToSystemSpacingBelowAnchor:self.topAnchor multiplier:1.0f],
                       [parent.bottomAnchor constraintGreaterThanOrEqualToSystemSpacingBelowAnchor:stack.bottomAnchor multiplier:1.0f],
                       safeAreaBottom,
                       [stack.leadingAnchor constraintEqualToSystemSpacingAfterAnchor:parent.readableContentGuide.leadingAnchor multiplier:1.0f],
                       [parent.readableContentGuide.trailingAnchor constraintEqualToSystemSpacingAfterAnchor:stack.trailingAnchor multiplier:1.0f]
//                       [stack.leadingAnchor constraintEqualToAnchor:parent.readableContentGuide.leadingAnchor],
//                       [parent.readableContentGuide.trailingAnchor constraintEqualToAnchor:stack.trailingAnchor]
                       ];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)configureWithActionButtonItems:(NSArray<MKDActionButtonItem *> *)actionButtonItems
{
    [self removeAllButtons];
    if(!actionButtonItems) { return; }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.15f;
    transition.type = kCATransitionFade;
    
    for(MKDActionButtonItem *item in actionButtonItems.reverseObjectEnumerator)
    {
        UIButton *button = self.buttonFactory(item.style);
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button addTarget:item.target action:item.action forControlEvents:UIControlEventTouchUpInside];
        
        [self.layer addAnimation:transition forKey:@"MKDFadeTransition"];
        [self.buttonStackView addArrangedSubview:button];
    }
}

- (void)removeAllButtons
{
    for(UIView *subview in self.buttonStackView.arrangedSubviews)
    {
        [self.buttonStackView removeArrangedSubview:subview];
        [subview removeFromSuperview];
    }
}

@end
