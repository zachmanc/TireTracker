//
//  TTRacer.h
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <Foundation/Foundation.h>
enum
{
    TTKid,
    TTJr1,
    TTJr2,
};
typedef NSInteger TTRacerGroup;
@interface TTRacer : NSObject
@property NSString *identifier;
@property NSString *first;
@property NSString *last;
@property NSMutableArray *tires;
@property TTRacerGroup group;
@end
