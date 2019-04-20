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
    switch(style)
    {
        case MKDActionButtonItemStylePrimary:
            return [MKDTintedActionButton buttonWithStyle:MKDTintedActionButtonStyleDefault];
        case MKDActionButtonItemStyleSecondary:
            return [MKDTintedActionButton buttonWithStyle:MKDTintedActionButtonStyleOutline];
    }
}

@end
