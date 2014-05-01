//
//  TTBarcodeScannerViewController.m
//  TireTracker
//
//  Created by Cory Zachman on 4/13/14.
//  Copyright (c) 2014 Cory Zachman. All rights reserved.
//

#import "TTBarcodeScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIFont+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "TTDataProvider.h"
@interface TTBarcodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
    UILabel *_label;
}
@end

@implementation TTBarcodeScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpLabels];
    
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.barcodeView addSubview:_highlightView];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.barcodeView.bounds.size.height - 40, self.barcodeView.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"(none)";
    [self.barcodeView addSubview:_label];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.barcodeView.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.barcodeView.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    [self.barcodeView bringSubviewToFront:_highlightView];
    [self.barcodeView bringSubviewToFront:_label];
    [self.view bringSubviewToFront:self.barcodeView];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            _label.text = detectionString;
            
            if (([self.tireLabel1.text isEqualToString:@""] || self.tireLabel1.text == nil) && ![self barcodeAlreadyScanned:detectionString]) {
                self.tireLabel1.text = detectionString;
            }
            
            if (([self.tireLabel2.text isEqualToString:@""] || self.tireLabel2.text == nil) && ![self barcodeAlreadyScanned:detectionString]) {
                self.tireLabel2.text = detectionString;
            }
            
            if (([self.tireLabel3.text isEqualToString:@""] || self.tireLabel3.text == nil) && ![self barcodeAlreadyScanned:detectionString]) {
                self.tireLabel3.text = detectionString;
            }
            
            if (([self.tireLabel4.text isEqualToString:@""] || self.tireLabel4.text == nil) && ![self barcodeAlreadyScanned:detectionString]) {
                self.tireLabel4.text = detectionString;
            }
            
            break;
        }
        else
            _label.text = @"(none)";
    }
    
    _highlightView.frame = highlightViewRect;
}

-(BOOL)barcodeAlreadyScanned:(NSString*)detectionString
{
    return ([self.tireLabel1.text isEqualToString:detectionString] || [self.tireLabel2.text isEqualToString:detectionString] || [self.tireLabel3.text isEqualToString:detectionString] || [self.tireLabel4.text isEqualToString:detectionString]);
}

-(void)setUpLabels
{
    [self.tireDeleteLabel1.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [self.tireDeleteLabel1 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
    [self.tireDeleteLabel1 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateHighlighted];
    [self.tireDeleteLabel1 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateSelected];
    [self.tireDeleteLabel1 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateDisabled];
    
    [self.tireDeleteLabel2.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [self.tireDeleteLabel2 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
    [self.tireDeleteLabel2 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateHighlighted];
    [self.tireDeleteLabel2 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateSelected];
    [self.tireDeleteLabel2 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateDisabled];
    
    [self.tireDeleteLabel3.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [self.tireDeleteLabel3 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
    [self.tireDeleteLabel3 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateHighlighted];
    [self.tireDeleteLabel3 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateSelected];
    [self.tireDeleteLabel3 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateDisabled];
    
    [self.tireDeleteLabel4.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [self.tireDeleteLabel4 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateNormal];
    [self.tireDeleteLabel4 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateHighlighted];
    [self.tireDeleteLabel4 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateSelected];
    [self.tireDeleteLabel4 setTitle:[NSString fontAwesomeIconStringForEnum:FATimesCircle] forState:UIControlStateDisabled];
}

-(IBAction)clear1Pressed:(id)sender
{
    self.tireLabel1.text = @"";
}

-(IBAction)clear2Pressed:(id)sender
{
    self.tireLabel2.text = @"";
}

-(IBAction)clear3Pressed:(id)sender
{
    self.tireLabel3.text = @"";
}

-(IBAction)clear4Pressed:(id)sender
{
    self.tireLabel4.text = @"";
}


-(IBAction)barcodeScannerBackPressed:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(IBAction)barcodeScannerSavePressed:(id)sender
{

    NSString *alertMessage = [self buildAlertMessage];

    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Validation Check"
                                                      message:alertMessage
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Save", nil];
    [message show];
}

-(NSString*)buildAlertMessage
{
    NSMutableDictionary *tireMap = [[NSMutableDictionary alloc] init];
    for (NSString *tire in self.racer.tires) {
        [tireMap setValue:@"YES" forKey:tire];
    }
    
    NSMutableDictionary *allTiresMap = [[NSMutableDictionary alloc] init];
    NSArray *racers = ((TTDataProvider*)[TTDataProvider sharedInstance]).racers;
    for (TTRacer *oneRacer in racers) {
        for (NSString *tire in oneRacer.tires) {
            [allTiresMap setValue:[NSString stringWithFormat:@"%@ %@",oneRacer.first,oneRacer.last ] forKey:tire];
        }
    }
    
    NSString *alertMessage = @"There were no validation errors with your tires. Click Save";
    NSMutableString *failureMessage = [[NSMutableString alloc] initWithString:@""];
    if ([tireMap valueForKey:self.tireLabel1.text] != nil && ![self.tireLabel1.text isEqualToString:@""]) {
        [failureMessage appendString:@"Tire 1 has already been added to this racer. \n"];
    }
    
    if ([tireMap valueForKey:self.tireLabel2.text] != nil && ![self.tireLabel2.text isEqualToString:@""]) {
        [failureMessage appendString:@"Tire 2 has already been added to this racer. \n"];
    }
    
    if ([tireMap valueForKey:self.tireLabel3.text] != nil && ![self.tireLabel3.text isEqualToString:@""]) {
        [failureMessage appendString:@"Tire 3 has already been added to this racer. \n"];
    }
    
    if ([tireMap valueForKey:self.tireLabel4.text] != nil && ![self.tireLabel4.text isEqualToString:@""]) {
        [failureMessage appendString:@"Tire 4 has already been added to this racer. \n"];
    }
    
    if ([failureMessage isEqualToString:@""]) {
        return alertMessage;
    }else{
        return failureMessage;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self saveTires];
    }
}
-(void)saveTires
{
    NSMutableDictionary *tireMap = [[NSMutableDictionary alloc] init];
    for (NSString *tire in self.racer.tires) {
        [tireMap setValue:@"YES" forKey:tire];
    }
    
    if ([tireMap valueForKey:self.tireLabel1.text] == nil && ![self.tireLabel1.text isEqualToString:@""]) {
        [self.racer.tires addObject:self.tireLabel1.text];
    }
    
    if ([tireMap valueForKey:self.tireLabel2.text] == nil && ![self.tireLabel2.text isEqualToString:@""]) {
        [self.racer.tires addObject:self.tireLabel2.text];
    }
    
    if ([tireMap valueForKey:self.tireLabel3.text] == nil && ![self.tireLabel3.text isEqualToString:@""]) {
        [self.racer.tires addObject:self.tireLabel3.text];
    }
    
    if ([tireMap valueForKey:self.tireLabel4.text] == nil && ![self.tireLabel4.text isEqualToString:@""]) {
        [self.racer.tires addObject:self.tireLabel4.text];
    }
    
    [[TTDataProvider sharedInstance] sync];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
