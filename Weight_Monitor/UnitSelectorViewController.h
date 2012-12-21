//
//  UnitSelectorViewController.h
//  WeightData
//
//  Created by John Mann on 10/24/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightEntry.h"
@class UnitSelectorViewController;

@protocol UnitSelectorViewControllerDelegate <NSObject>
- (void)unitSelectorDone:(UnitSelectorViewController *)controller;
- (void)unitSelector:(UnitSelectorViewController *)controller changedUnits:(WeightUnits)units;
@end

@interface UnitSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
}

@property (strong, nonatomic) IBOutlet UIPickerView *unitPickerView;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) id<UnitSelectorViewControllerDelegate> delegate;
@property (assign, nonatomic) WeightUnits assignedUnit;

- (IBAction)done:(id)sender;

@end
