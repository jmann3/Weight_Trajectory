//
//  ViewController.m
//  WeightData
//
//  Created by John Mann on 10/23/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "EnterWeightViewController.h"
#import "WeightEntry.h"
#import "WeightHistoryViewController.h"

@interface EnterWeightViewController ()
@property (nonatomic, strong) NSDate* currentDate;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@end

static NSString * const UNIT_SELECTOR_SEGUE = @"Unit Selector Segue";

@implementation EnterWeightViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // initialize weightHistory
    //self.weightHistory = [self.tabBarController.viewControllers objectAtIndex:2];
    self.weightHistory = (WeightHistoryViewController *)[[self.tabBarController.viewControllers objectAtIndex:2] topViewController];
    
    // create Decimal Keypad for text input
    //self.weightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // configure number formatter
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.numberFormatter setMinimum:[NSNumber numberWithFloat:0.0f]];
    
    // create custom units button
    self.unitsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unitsButton.frame = CGRectMake(0.0f, 0.0f, 25.0f, 17.0f);
    self.unitsButton.backgroundColor = [UIColor lightGrayColor];
    self.unitsButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.unitsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.unitsButton setTitle:@"lbs" forState:UIControlStateNormal];
    [self.unitsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.unitsButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.unitsButton addTarget:self action:@selector(changeUnits:) forControlEvents:UIControlEventTouchUpInside];
    self.weightTextField.rightView = self.unitsButton;
    self.weightTextField.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    // set the current time and date
    self.currentDate = [NSDate date];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:self.currentDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterShortStyle];
    
    // clear the text field
    self.weightTextField.text = @"";
    [self.weightTextField becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    tempWeight = self.weightTextField.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (IBAction)saveWeight {
     
    // save weight to the model
    NSNumber *weight = [self.numberFormatter numberFromString:self.weightTextField.text];
    WeightEntry * entry = [[WeightEntry alloc] initWithWeight:[weight floatValue] usingUnits:defaultUnits forDate:self.currentDate];
    [self.weightHistory addWeight:entry];
    
    // automatically move to third tab,table view
    self.tabBarController.selectedIndex = 2;
}

- (IBAction)handleDownwardSwipe:(id)sender {
    
    // get rid of keyboard
    [self.weightTextField resignFirstResponder];
    [self saveWeight];
}

- (IBAction)handleUpwardSwipe:(id)sender {
    // get rid of keyboard
    [self.weightTextField becomeFirstResponder];
}

- (IBAction)changeUnits:(id)sender {
    
    [self performSegueWithIdentifier:UNIT_SELECTOR_SEGUE sender:self];
}

// prepare for segue and set default unit value

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:UNIT_SELECTOR_SEGUE]) {
        UnitSelectorViewController *unitSelectorViewController = segue.destinationViewController;
        unitSelectorViewController.delegate = self;
        [unitSelectorViewController setAssignedUnit:self.unitsButton.titleLabel.text == @"lbs" ? 0 : 1];
    }
}

#pragma mark UnitSelectorViewController methods
- (void)unitSelector:(UnitSelectorViewController *)controller changedUnits:(WeightUnits)units {
    
    switch (units) {
        case defaultUnits:
            self.unitsButton.titleLabel.text = @"lbs";
            break;
        case metricUnits:
            self.unitsButton.titleLabel.text = @"Kg";
            
        default:
            break;
    }
}

- (void)unitSelectorDone:(UnitSelectorViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^{
        self.weightTextField.text = tempWeight;
    }];
}

@end
