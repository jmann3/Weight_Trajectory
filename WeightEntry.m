//
//  WeightEntry.m
//  WeightData
//
//  Created by John Mann on 10/23/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "WeightEntry.h"
//#import "WeightHistoryViewController.h"

@implementation WeightEntry


- (id)initWithWeight:(float)weight usingUnits:(WeightUnits)units forDate:(NSDate *)date {
    if (self = [super init]) {
        self.weight = weight;
        self.units = units;
        self.date = date;
    }
    return self;
}


- (NSString *)stringForWeightInUnit:(WeightUnits)unit {
    
    NSString *unitLabel = [WeightEntry stringForRow:unit];
    
    return [NSString stringWithFormat:@"%.02f %@", self.weight, unitLabel];
}

// return units based on which row is selected in UnitSelectorViewController
+ (NSString *)stringForRow:(NSInteger)row {
    
        switch (row) {
        case defaultUnits:
            return @"lbs";
            break;
            
        case metricUnits:
            return @"Kg";
            break;
            
        default:
            return nil;
            break;
    }
}

@end
