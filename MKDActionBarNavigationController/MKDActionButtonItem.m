//
//  MKDActionButtonItem.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 17.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDActionButtonItem.h"

@interface MKDActionButtonItem ()
@property (copy, nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) MKDActionButtonItemStyle style;
@property (weak, nonatomic, readwrite) id target;
@property (nonatomic, readwrite) SEL action;
@end

@implementation MKDActionButtonItem

- (instancetype)initWithTitle:(NSString *)title style:(MKDActionButtonItemStyle)style target:(id)target action:(SEL)action
{
    NSParameterAssert(title);
    NSParameterAssert(target);
    
    self = [super init];
    if(self)
    {
        self.title = title;
        self.style = style;
        self.target = target;
        self.action = action;
    }
    return self;
}

@end
