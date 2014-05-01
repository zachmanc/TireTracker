//
//  TTTireListViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/13/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTTireListViewController.h"
#import "TTBarcodeScannerViewController.h"
@interface TTTireListViewController ()

@end

@implementation TTTireListViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)newTireButtonPressed:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TTBarcodeScannerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BarcodeScannerViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    vc.racer = self.racer;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

-(IBAction)tiresListBackButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TireTableSegue"])
    {
        self.tireTableViewController = [segue destinationViewController];
        [self.tireTableViewController setRacer:self.racer];
    }
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

@end
