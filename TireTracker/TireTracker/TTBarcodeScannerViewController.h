//
//  TTBarcodeScannerViewController.h
//  TireTracker
//
//  Created by Cory Zachman on 4/13/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRacer.h"
@interface TTBarcodeScannerViewController : UIViewController
@property IBOutlet UIView *barcodeView;
@property IBOutlet UITextField *tireLabel1;
@property IBOutlet UITextField *tireLabel2;
@property IBOutlet UITextField *tireLabel3;
@property IBOutlet UITextField *tireLabel4;

@property IBOutlet UIButton *tireDeleteLabel1;
@property IBOutlet UIButton *tireDeleteLabel2;
@property IBOutlet UIButton *tireDeleteLabel3;
@property IBOutlet UIButton *tireDeleteLabel4;

@property TTRacer *racer;

@end
