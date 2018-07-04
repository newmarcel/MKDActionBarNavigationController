//
//  MKDActionButtonHosting.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 14.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKDActionButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol for `UIViewController`s to host action button items for
 display in a `MKDActionBarNavigationController`.
 */
@protocol MKDActionButtonHosting <NSObject>

/**
 Action button items for `MKDActionBarNavigationController`.
 */
@property (nonatomic, readonly) NSArray<MKDActionButtonItem *> *actionBarButtonItems;

@end

NS_ASSUME_NONNULL_END
