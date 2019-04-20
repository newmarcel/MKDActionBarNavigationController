//
//  MKDTintedActionButton.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 22.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MKDTintedActionButtonStyle) {
    MKDTintedActionButtonStyleDefault = 0,
    MKDTintedActionButtonStyleOutline
};

/**
 A generic button that uses the view's tint color for background and highlight colors.
 */
@interface MKDTintedActionButton : UIButton
+ (instancetype)buttonWithStyle:(MKDTintedActionButtonStyle)style;
@end

NS_ASSUME_NONNULL_END
