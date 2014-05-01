//
//  TTEditRacerTableTableViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/10/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTEditRacerTableViewController.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "TTTireListViewController.h"

@interface TTEditRacerTableViewController ()

@end

@implementation TTEditRacerTableViewController

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
    [self.editTiresButton.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [self.editTiresButton setTitle:[NSString fontAwesomeIconStringForEnum:FAPencil] forState:UIControlStateNormal];
    [self.editTiresButton setTitle:[NSString fontAwesomeIconStringForEnum:FAPencil] forState:UIControlStateHighlighted];
    [self.editTiresButton setTitle:[NSString fontAwesomeIconStringForEnum:FAPencil] forState:UIControlStateSelected];
    [self.editTiresButton setTitle:[NSString fontAwesomeIconStringForEnum:FAPencil] forState:UIControlStateDisabled];
    self.segmentControl.enabled = NO;
    [self.segmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];

}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)segmentChanged:(id)sender
{
    self.tiresAvailable.text = [NSString stringWithFormat:@"%lu",[self groupToMax:self.segmentControl.selectedSegmentIndex]];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(void)updateUI
{
    if(self.racer != nil)
    {
        self.firstNameTextField.text = self.racer.first;
        self.lastNameTextField.text = self.racer.last;
        self.segmentControl.selectedSegmentIndex = self.racer.group;
        self.tiresAvailable.text = [NSString stringWithFormat:@"%lu",[self groupToMax:self.racer.group]];
        self.tiresUsed.text = [NSString stringWithFormat:@"%lu",self.racer.tires.count];

    }
}


-(NSInteger)groupToMax:(NSInteger)group
{
    switch (group) {
        case TTKid:
            return 4;
            break;
        case TTJr1:
            return 16;
            break;
        default:
            return 16;
            break;
    }
}

-(IBAction)editRacerButtonPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TTTireListViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TireListViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    vc.racer = self.racer;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
