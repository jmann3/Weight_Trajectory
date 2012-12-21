//
//  WeightHistory1ViewController.h
//  WeightData
//
//  Created by John Mann on 10/26/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightEntry.h"

@class DataStore;

@interface WeightHistoryViewController : UITableViewController {
    
    DataStore *sharedDataStore;
    NSIndexPath *selectedIndex;
}

@property (nonatomic, strong) NSMutableArray *weights;

- (void)addWeight:(WeightEntry *)entry;

@end
