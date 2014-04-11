//
//  TTDataProvider.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTDataProvider.h"
#import "TTRacer.h"
@implementation TTDataProvider
@synthesize racers;
+ (id)sharedInstance {
    static TTDataProvider *shareDataProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDataProvider = [[self alloc] init];
    });
    return shareDataProvider;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.racers = [[NSMutableArray alloc] initWithCapacity:16];
    }
    return self;
}

-(void)clearData
{
    self.racers = [[NSMutableArray alloc] initWithCapacity:16];
}

-(void)seedData
{
    TTRacer *racer = [[TTRacer alloc] init];
    racer.identifier = [[NSUUID UUID] UUIDString];
    racer.first = @"Cory";
    racer.last = @"Zachman";
    
    TTRacer *racer1 = [[TTRacer alloc] init];
    racer1.identifier = [[NSUUID UUID] UUIDString];
    racer1.first = @"Brandon";
    racer1.last = @"Gouin";
    
    TTRacer *racer2 = [[TTRacer alloc] init];
    racer2.identifier = [[NSUUID UUID] UUIDString];
    racer2.first = @"John";
    racer2.last = @"Snelson";
    
    TTRacer *racer3 = [[TTRacer alloc] init];
    racer3.identifier = [[NSUUID UUID] UUIDString];
    racer3.first = @"Kellen";
    racer3.last = @"Frye";
    
    TTRacer *racer4 = [[TTRacer alloc] init];
    racer4.identifier = [[NSUUID UUID] UUIDString];
    racer4.first = @"Britt";
    racer4.last = @"Kerridge";
    
    TTRacer *racer5 = [[TTRacer alloc] init];
    racer5.identifier = [[NSUUID UUID] UUIDString];
    racer5.first = @"Kenneth";
    racer5.last = @"Leroue";
    
    TTRacer *racer6 = [[TTRacer alloc] init];
    racer6.identifier = [[NSUUID UUID] UUIDString];
    racer6.first = @"Bryan";
    racer6.last = @"Pauk";
    
    TTRacer *racer7 = [[TTRacer alloc] init];
    racer7.identifier = [[NSUUID UUID] UUIDString];
    racer7.first = @"Richard";
    racer7.last = @"Fliam";
    
    TTRacer *racer8 = [[TTRacer alloc] init];
    racer8.identifier = [[NSUUID UUID] UUIDString];
    racer8.first = @"Mark";
    racer8.last = @"Niebur";
    
    TTRacer *racer9 = [[TTRacer alloc] init];
    racer9.identifier = [[NSUUID UUID] UUIDString];
    racer9.first = @"Neill";
    racer9.last = @"Kipp";
    
    TTRacer *racer10 = [[TTRacer alloc] init];
    racer10.identifier = [[NSUUID UUID] UUIDString];
    racer10.first = @"Chris";
    racer10.last = @"Lintz";
    
    [self.racers addObject:racer1];
    [self.racers addObject:racer2];
    [self.racers addObject:racer3];
    [self.racers addObject:racer4];
    [self.racers addObject:racer5];
    [self.racers addObject:racer6];
    [self.racers addObject:racer7];
    [self.racers addObject:racer8];
    [self.racers addObject:racer9];
    [self.racers addObject:racer10];
}
@end
