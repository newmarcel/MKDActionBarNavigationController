//
//  MKDActionBar.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 15.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKDActionButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKDActionBar : UIView
@property (nonatomic, readonly) UIVisualEffectView *visualEffectView;
@property (nonatomic, readonly) UIStackView *buttonStackView;

@property (copy, nonatomic) UIButton *(^buttonFactory)(MKDActionButtonItemStyle style);

- (void)configureWithActionButtonItems:(NSArray <MKDActionButtonItem *> *)actionButtonItems;

@end

NS_ASSUME_NONNULL_END
