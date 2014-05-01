//
//  TTDataProvider.m
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTDataProvider.h"
#import "TTRacer.h"
#import <Dropbox/Dropbox.h>
@interface TTDataProvider()
@property DBDatastore *store;
@end

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
        DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
        self.store = [DBDatastore openDefaultStoreForAccount:account error:nil];
        [self loadRacers];
    }
    return self;
}

-(void)clearData
{
    self.racers = [[NSMutableArray alloc] initWithCapacity:16];
}

-(void)loadRacers
{
    [self clearData];
    DBTable *racerTable = [self.store getTable:@"racers"];
    NSArray *records = [racerTable query:nil error:nil];
    
    for (DBRecord *record in records) {
        TTRacer *racer = [[TTRacer alloc] init];
        racer.identifier = [record.fields valueForKey:@"id"];
        racer.first = [record.fields valueForKey:@"first"];
        racer.last = [record.fields valueForKey:@"last"];
        racer.tires = [[record.fields valueForKey:@"tires"] values];
        
        racer.group = [[record.fields valueForKey:@"group"] integerValue];
        [self.racers addObject:racer];
    }
}

-(void)sync
{
    
    DBTable *racerTable = [self.store getTable:@"racers"];
    for (TTRacer *racer in self.racers){
        
        NSArray *records = [racerTable query:@{@"id":racer.identifier} error:nil];
        NSDictionary *racerDictionary = @{@"id":racer.identifier,@"first": racer.first,@"last":racer.last,@"group":[NSNumber numberWithLong:racer.group],@"tires":racer.tires};

        if (records != nil && records.count > 0 && [[((DBRecord*)[records objectAtIndex:0]).fields valueForKey:@"id"] isEqualToString:racer.identifier]) {
            [(DBRecord*)[records objectAtIndex:0] update:racerDictionary];
        }else{
            NSDictionary *racerDictionary = @{@"id":racer.identifier,@"first": racer.first,@"last":racer.last,@"group":[NSNumber numberWithLong:racer.group],@"tires":racer.tires};
            [racerTable insert:racerDictionary];
        }
    }
    
    DBError *error;
    [self.store sync:&error];
    
    if (error != nil) {
        NSLog(@"Sync Error: %@",[error description]);
    }
}

-(void)removeAll
{
    DBTable *racerTable = [self.store getTable:@"racers"];
    NSArray *records = [racerTable query:nil error:nil];
    for (DBRecord *record in records)
    {
        [record deleteRecord];
    }
    
    [self.store sync:nil];
}

-(void)buildDropboxDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:self.racers.count];

}


@end
