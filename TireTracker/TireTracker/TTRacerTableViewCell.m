//
//  TTRacerTableViewCell.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTRacerTableViewCell.h"
@interface TTRacerTableViewCell()
{
    TTRacer *_racer;
}
@end

@implementation TTRacerTableViewCell
@synthesize associationLabel;
@synthesize nameLabel;

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

-(void)setRacer:(TTRacer *)racer
{
    _racer = racer;
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",racer.first, racer.last];
    self.associationLabel.text = @"12-14";
}

-(TTRacer*)racer
{
    return _racer;
}
@end
