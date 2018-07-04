//
//  MKDActionButtonItem.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 17.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MKDActionButtonItemStyle) {
    MKDActionButtonItemStylePrimary = 0,
    MKDActionButtonItemStyleSecondary
};

/**
 A button for items that can be added to a bar that
 appears at the bottom of the screen.
 */
@interface MKDActionButtonItem : NSObject

/**
 A button title
 */
@property (copy, nonatomic, readonly) NSString *title;

/**
 The button style for primary and secondary actions
 */
@property (nonatomic, readonly) MKDActionButtonItemStyle style;

/**
 The target that will be called for the supplied `action`
 */
@property (weak, nonatomic, readonly) id target;

/**
 The action that will be performed when the button is tapped
 */
@property (nonatomic, readonly) SEL action;

- (instancetype)init NS_UNAVAILABLE;

/**
 The designated initializer.

 @param title A button title
 @param style A button style, e.g. .primary
 @param target The target object for receiving the `action`
 @param action An action that will be performed when the button is tapped
 @return A new instanc.e
 */
- (instancetype)initWithTitle:(NSString *)title
                        style:(MKDActionButtonItemStyle)style
                       target:(id)target
                       action:(SEL)action NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
