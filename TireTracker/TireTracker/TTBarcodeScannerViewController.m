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

@interface TTBarcodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>
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
            break;
        }
        else
            _label.text = @"(none)";
    }
    
    _highlightView.frame = highlightViewRect;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
