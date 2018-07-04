//
//  MKDActionBarNavigationController.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 14.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKDActionButtonHosting.h"

NS_ASSUME_NONNULL_BEGIN

// WARNING: For your own safety, do not change this nav controller's delegate
// or all hell will break loose.

@interface MKDActionBarNavigationController : UINavigationController

/**
 Returns a configured button for use as action button.

 @param style The control style
 @return A new instance
 */
- (UIButton *)configuredActionButtonForStyle:(MKDActionButtonItemStyle)style;

/**
 Notify the navigation controller that the contents of the view controller's
 `bottomActionButtonItems` property have changed.
 */
- (void)actionButtonItemsDidChange;

@end

NS_ASSUME_NONNULL_END
