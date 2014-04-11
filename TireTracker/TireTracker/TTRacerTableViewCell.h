//
//  TTRacerTableViewCell.h
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRacer.h"
@interface TTRacerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *associationLabel;
@property TTRacer *racer;
@end
