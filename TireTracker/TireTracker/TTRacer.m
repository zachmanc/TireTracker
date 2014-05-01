//
//  TTRacer.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTRacer.h"

@implementation TTRacer
-(id)init
{
    self = [super init];
    if (self) {
        self.identifier = [[[NSUUID UUID] UUIDString] substringToIndex:31];
        self.tires = [[NSMutableArray alloc] initWithCapacity:16];
    }
    return self;
}
@end
