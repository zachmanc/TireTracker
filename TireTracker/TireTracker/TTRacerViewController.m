//
//  TTRacerViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTRacerViewController.h"
#import "TTDataProvider.h"
#import "TTRacerTableViewCell.h"
#import "TTEditRacerViewController.h"
#import <Dropbox/Dropbox.h>
@interface TTRacerViewController ()
@property TTDataProvider *dataProvider;
@end

@implementation TTRacerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataProvider = [TTDataProvider sharedInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataProvider = [TTDataProvider sharedInstance];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.dataProvider loadRacers];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (IBAction)logoutButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dataProvider clearData];
}

- (IBAction)addButtonPressed:(id)sender
{
    [self.dataProvider.racers addObject:[[TTRacer alloc] init]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    __block TTEditRacerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditRacerViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [vc setRacer:[self.dataProvider.racers objectAtIndex:self.dataProvider.racers.count-1]];
    [self presentViewController:vc animated:YES completion:^{
    }];
}

#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *racerTableIdentifier = @"RaceViewCell";

    TTRacerTableViewCell *racerTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:racerTableIdentifier forIndexPath:indexPath];
    
    
    if (racerTableViewCell == nil) {
        racerTableViewCell = [[TTRacerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:racerTableIdentifier];
    }
    
    [racerTableViewCell setRacer:[self.dataProvider.racers objectAtIndex:indexPath.row]];
    return racerTableViewCell;
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
    return self.dataProvider.racers.count;
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    __block TTEditRacerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EditRacerViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc setRacer:[self.dataProvider.racers objectAtIndex:indexPath.row]];
    [self presentViewController:vc animated:YES completion:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
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
@end
