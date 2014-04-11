//
//  TTViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTLoginViewController.h"
#import <Dropbox/Dropbox.h>
#import "TTRacerViewController.h"

@interface TTLoginViewController ()

@end

@implementation TTLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View Appeared");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonSelected:(id)sender
{
    DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
    if (account) {
        NSLog(@"App already linked");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RacerViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    } else {
        [[DBAccountManager sharedManager] linkFromController:self];
    }
}

@end
