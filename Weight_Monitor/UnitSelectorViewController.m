//
//  UnitSelectorViewController.m
//  WeightData
//
//  Created by John Mann on 10/24/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "UnitSelectorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UnitSelectorViewController ()

@end

@implementation UnitSelectorViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)addGradientLayer {
    
    // build gradients overlays
    CAGradientLayer *topGradient = [[CAGradientLayer alloc] init];
    topGradient.name = @"Top Gradient";
    
    
    // make it half the height
    CGRect frame = self.doneButton.layer.bounds;
    frame.size.height /= 2.0f;
    NSLog(@"frame height is %f", frame.size.height);
    topGradient.frame = frame;
    UIColor *topColor = [UIColor colorWithWhite:1.0f alpha:0.25f];
    UIColor *bottomColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
    topGradient.colors = [NSArray arrayWithObjects:(__bridge id)topColor.CGColor, (__bridge id)bottomColor.CGColor, nil];
    topGradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:0.0], nil];
    
    CAGradientLayer *bottomGradient = [[CAGradientLayer alloc] init];
    bottomGradient.name = @"Bottom Gradient";
    
    //make it half the height
    frame = self.doneButton.layer.bounds;
    frame.size.height /= 2.0f;
    
    // move it to the bottom
    frame.origin.y = frame.size.height;
    bottomGradient.frame = frame;
    topColor = [UIColor colorWithWhite:0.0f alpha:0.20f];
    bottomColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    bottomGradient.colors = [NSArray arrayWithObjects:(__bridge id)topColor.CGColor, (__bridge id)bottomColor.CGColor, nil];
    bottomGradient.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:0.0], nil];
    
    // round the corners
    [self.doneButton.layer setCornerRadius:8.0f];
    
    // clip sublayers
    [self.doneButton.layer setMasksToBounds:YES];
    
    // add a border
    [self.doneButton.layer setBorderWidth:2.0f];
    [self.doneButton.layer setBorderColor:[[UIColor lightTextColor] CGColor]];
    
    // add the gradient layers
    [self.doneButton.layer addSublayer:topGradient];
    [self.doneButton.layer addSublayer:bottomGradient];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // set the default units
    [self.unitPickerView selectRow:self.assignedUnit inComponent:0 animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self addGradientLayer];
}

- (void)viewDidLayoutSubviews {
    
    // adjust width of button layers
    CALayer *layer = self.doneButton.layer;
    CGFloat width = layer.bounds.size.width;
    for (CALayer *sublayer in layer.sublayers) {
        if ([sublayer.name hasSuffix:@"Gradient"]) {
            CGRect frame = sublayer.frame;
            frame.size.width = width;
            sublayer.frame = frame;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.delegate unitSelectorDone:self];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - UIPickerViewDataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return 2;
}

#pragma mark pickerview delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [WeightEntry stringForRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.delegate unitSelector:self changedUnits:row];
}

@end
