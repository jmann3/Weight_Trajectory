//
//  DetailViewController.h
//  WeightData
//
//  Created by Arielle Mann on 10/30/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightEntry.h"

@interface DetailViewController : UITableViewController {
    
    DataStore *sharedDataStore;
    
}

@property NSIndexPath *selectedIndex;

@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) IBOutlet UITextField *averageTextField;
@property (strong, nonatomic) IBOutlet UITextField *lossTextField;
@property (strong, nonatomic) IBOutlet UITextField *gainTextField;

- (CGFloat)correctedWeight:(CGFloat)weight InUnits:(WeightUnits)referenceUnits fromUnits:(WeightUnits)currentUnits;

@end
