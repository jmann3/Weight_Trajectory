//
//  ViewController.h
//  WeightData
//
//  Created by John Mann on 10/23/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitSelectorViewController.h"
@class WeightHistoryViewController;

@interface EnterWeightViewController : UIViewController <UITextFieldDelegate, UnitSelectorViewControllerDelegate> {
    
    NSString *tempWeight;
    
}

@property (nonatomic, strong) WeightHistoryViewController *weightHistory;
@property (nonatomic, strong) IBOutlet UITextField *weightTextField;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) UIButton *unitsButton;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *downSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *upSwipeRecognizer;

- (IBAction)saveWeight;
- (IBAction)changeUnits:(id)sender;
- (IBAction)handleDownwardSwipe:(id)sender;
- (IBAction)handleUpwardSwipe:(id)sender;

@end
