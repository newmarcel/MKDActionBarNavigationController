//
//  MKDMainViewController.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 14.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDMainViewController.h"

static NSString * const ShowSegueIdentifier = @"showDetails";

#define kNumberOfRows 30

@interface MKDMainViewController ()
@end

@implementation MKDMainViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = NSLocalizedString(@"Row", @"Row");
    cell.detailTextLabel.text = @(indexPath.row + 1).stringValue;
    
    return cell;
}

#pragma mark -

- (void)continueToNextScreen
{
    [self performSegueWithIdentifier:ShowSegueIdentifier sender:nil];
}

#pragma mark - MKDActionButtonHosting

- (NSArray<MKDActionButtonItem *> *)actionBarButtonItems
{
    return @[
             [[MKDActionButtonItem alloc] initWithTitle:NSLocalizedString(@"Continue", @"Continue")
                                                  style:MKDActionButtonItemStylePrimary
                                                 target:self
                                                 action:@selector(continueToNextScreen)]
             ];
}

@end
