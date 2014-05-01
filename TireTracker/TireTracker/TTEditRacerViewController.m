//
//  TTEditRacerViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/10/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTEditRacerViewController.h"
#import "TTDataProvider.h"
@interface TTEditRacerViewController ()

@end

@implementation TTEditRacerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.editRacerTableViewController updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditRacerTableSegue"])
    {
        self.editRacerTableViewController = [segue destinationViewController];
        [self.editRacerTableViewController setRacer:self.racer];
    }
}

-(void)enterEditMode
{
    [self.editButtonBarItem setTitle:@"Save"];
    self.editRacerTableViewController.firstNameTextField.enabled = YES;
    self.editRacerTableViewController.lastNameTextField.enabled = YES;
    self.editRacerTableViewController.groupTextField.enabled = YES;
    self.editRacerTableViewController.segmentControl.enabled = YES;
    [self.editRacerTableViewController.firstNameTextField becomeFirstResponder];
}

-(void)savedButtonPressed
{
    [self.editButtonBarItem setTitle:@"Edit"];
    [self.view endEditing:YES];
    self.editRacerTableViewController.segmentControl.enabled = NO;
    [self updateRacer];
    [[TTDataProvider sharedInstance] sync];
}

-(void)updateRacer
{
    self.racer.first = self.editRacerTableViewController.firstNameTextField.text;
    self.racer.last = self.editRacerTableViewController.lastNameTextField.text;
    self.racer.group = self.editRacerTableViewController.segmentControl.selectedSegmentIndex;
}

#pragma mark - Navigation

-(IBAction)editButtonPressed:(id)sender
{
    self.inEditMode = !self.inEditMode;
    if (self.inEditMode) {
        [self enterEditMode];
    }else{
        [self savedButtonPressed];
    }
}

-(IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
@end
