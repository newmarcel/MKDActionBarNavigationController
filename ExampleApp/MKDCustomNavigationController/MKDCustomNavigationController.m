//
//  MKDCustomNavigationController.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 02.07.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDCustomNavigationController.h"
#import "MKDTintedActionButton.h"

@implementation MKDCustomNavigationController

- (UIButton *)configuredActionButtonForStyle:(MKDActionButtonItemStyle)style
{
    MKDTintedActionButton *button = [MKDTintedActionButton buttonWithType:UIButtonTypeCustom];
    
    switch(style)
    {
        case MKDActionButtonItemStylePrimary:
            break;
        case MKDActionButtonItemStyleSecondary:
            button.tintColor = [UIColor colorWithWhite:0.74f alpha:1.0f];
            break;
    }
    
    return button;
}

@end
