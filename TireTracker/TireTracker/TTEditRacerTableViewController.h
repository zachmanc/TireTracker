//
//  TTEditRacerTableTableViewController.h
//  TireTracker
//
//  Created by Cory Zachman on 4/10/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRacer.h"

@interface TTEditRacerTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupTextField;
@property TTRacer *racer;
-(void)updateUI;
-(void)editButtonPressed;
@end
