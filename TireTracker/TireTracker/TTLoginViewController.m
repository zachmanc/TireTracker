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
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
@interface TTLoginViewController ()

@end

@implementation TTLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.dropBoxLoginButton.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:20]];
    [self.dropBoxLoginButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[NSString fontAwesomeIconStringForEnum:FADropbox],@"Login With Dropbox",[NSString fontAwesomeIconStringForEnum:FADropbox]] forState:UIControlStateNormal];
    [self.dropBoxLoginButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[NSString fontAwesomeIconStringForEnum:FADropbox],@"Login With Dropbox",[NSString fontAwesomeIconStringForEnum:FADropbox]] forState:UIControlStateHighlighted];
    [self.dropBoxLoginButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[NSString fontAwesomeIconStringForEnum:FADropbox],@"Login With Dropbox",[NSString fontAwesomeIconStringForEnum:FADropbox]] forState:UIControlStateSelected];
    [self.dropBoxLoginButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",[NSString fontAwesomeIconStringForEnum:FADropbox],@"Login With Dropbox",[NSString fontAwesomeIconStringForEnum:FADropbox]] forState:UIControlStateDisabled];
}

-(void)viewDidAppear:(BOOL)animated
{
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
