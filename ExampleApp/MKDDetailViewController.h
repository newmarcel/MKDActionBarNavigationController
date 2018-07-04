//
//  MKDDetailViewController.h
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 16.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKDActionButtonHosting.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKDDetailViewController : UITableViewController <MKDActionButtonHosting>

- (IBAction)dismissButtons:(id)sender;

@end

NS_ASSUME_NONNULL_END
