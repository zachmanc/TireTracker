//
//  TTTireTableViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/13/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTTireTableViewController.h"
#import "TTTireTableViewCell.h"
#import "TTDataProvider.h"
@interface TTTireTableViewController () <UIAlertViewDelegate>
@property NSIndexPath *deletePath;
@end

@implementation TTTireTableViewController
@synthesize deletePath;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *racerTableIdentifier = @"TireViewCell";
    
    TTTireTableViewCell *tireViewCell = [self.tableView dequeueReusableCellWithIdentifier:racerTableIdentifier forIndexPath:indexPath];
    
    
    if (tireViewCell == nil) {
        tireViewCell = [[TTTireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:racerTableIdentifier];
    }
    
    tireViewCell.tireLabel.text = [self.racer.tires objectAtIndex:indexPath.row];
    return tireViewCell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 32.0f;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.racer.tires.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
//    __block TTEditRacerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditRacerViewController"];
//    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//    [vc setRacer:[self.dataProvider.racers objectAtIndex:indexPath.row]];
//    [self presentViewController:vc animated:YES completion:^{
//        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
-(void)deleteTire
{
    [self.racer.tires removeObjectAtIndex:deletePath.row];
    NSArray *indexes = [[NSArray alloc] initWithObjects:deletePath, nil];
    [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
    [[TTDataProvider sharedInstance] sync];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleteTire];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.deletePath = indexPath;
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Remove Tire"
                                                          message:@"Please enter admin password"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Delete", nil];
        
        message.alertViewStyle = UIAlertViewStyleSecureTextInput;

        
        
        [message show];
    }
}
@end
