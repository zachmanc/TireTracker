//
//  TTTireTableViewCell.m
//  TireTracker
//
//  Created by Cory Zachman on 5/1/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTTireTableViewCell.h"

@implementation TTTireTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
