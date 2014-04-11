//
//  TTDataProvider.h
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTDataProvider : NSObject
@property NSMutableArray *racers;
-(void)seedData;
+ (id)sharedInstance;
-(void)clearData;
@end
