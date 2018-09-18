//
//  MKDDetailViewController.m
//  MKDBottomActionButtons
//
//  Created by Marcel Dierkes on 16.06.18.
//  Copyright © 2018 Marcel Dierkes. All rights reserved.
//

#import "MKDDetailViewController.h"
#import "MKDCustomNavigationController.h"

static NSString * const ShowSegueIdentifier = @"showMore";

#define kNumberOfRows 10

@interface MKDDetailViewController ()
@property (nonatomic) BOOL actionButtonsVisible;
@end

@implementation MKDDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.actionButtonsVisible = YES;
}

- (IBAction)dismissButtons:(id)sender
{
    MKDCustomNavigationController *nav = (MKDCustomNavigationController *)self.navigationController;
    
    self.actionButtonsVisible = !self.actionButtonsVisible;
    [nav setNeedsActionButtonUpdate];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"Extended Information", @"Extended Information");
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

- (void)returnToPreviousScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)continueToNextScreen
{
    [self performSegueWithIdentifier:ShowSegueIdentifier sender:nil];
}

#pragma mark - MKDActionButtonHosting

- (NSArray<MKDActionButtonItem *> *)actionBarButtonItems
{
    if(!self.actionButtonsVisible)
    {
        return @[];
    }
    
    return @[
             [[MKDActionButtonItem alloc] initWithTitle:NSLocalizedString(@"Apply", @"Apply")
                                                  style:MKDActionButtonItemStylePrimary
                                                 target:self
                                                 action:@selector(continueToNextScreen)],
             [[MKDActionButtonItem alloc] initWithTitle:NSLocalizedString(@"Discard", @"Discard")
                                                  style:MKDActionButtonItemStyleSecondary
                                                 target:self
                                                 action:@selector(returnToPreviousScreen)]
             ];
}

@end
