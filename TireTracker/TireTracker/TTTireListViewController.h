//
//  TTTireListViewController.h
//  TireTracker
//
//  Created by Cory Zachman on 4/13/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRacer.h"
#import "TTTireTableViewController.h"
@interface TTTireListViewController : UIViewController
@property (weak, nonatomic) IBOutlet TTTireTableViewController *tireTableViewController;
@property TTRacer *racer;
@end
