//
//  TTAppDelegate.h
//  TireTracker
//
//  Created by Cory Zachman on 4/9/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Dropbox/Dropbox.h>

@interface TTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property DBAccount *account;
@end
