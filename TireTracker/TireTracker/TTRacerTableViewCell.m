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
    self.associationLabel.text = [NSString stringWithFormat:@"%lu / %lu",self.racer.tires.count,[self groupToMax]];
}

-(NSInteger)groupToMax
{
    switch (self.racer.group) {
        case TTKid:
            return 4;
            break;
        case TTJr1:
            return 16;
            break;
        default:
            return 16;
            break;
    }
}

-(TTRacer*)racer
{
    return _racer;
}
@end
