//
//  TTRacerViewController.h
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTRacerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property IBOutlet UITableView *tableView;
@end