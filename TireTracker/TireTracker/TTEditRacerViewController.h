//
//  TTEditRacerViewController.h
//  TireTracker
//
//  Created by Cory Zachman on 4/10/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRacer.h"
#import "TTEditRacerTableViewController.h"
@interface TTEditRacerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property TTRacer *racer;
@property (weak, nonatomic) IBOutlet TTEditRacerTableViewController *editRacerTableViewController;
@property (weak, nonatomic) IBOutlet UIView *editTableViewController;
@end
