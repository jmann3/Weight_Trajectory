//
//  WeightEntry.h
//  WeightData
//
//  Created by John Mann on 10/23/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum weightTypes {
    defaultUnits,
    metricUnits
} WeightUnits;


@interface WeightEntry : NSObject {
    
}

@property (nonatomic, assign) float weight;
@property (nonatomic, assign) WeightUnits units;
@property (nonatomic, strong) NSDate *date;

- (id)initWithWeight:(float)weight usingUnits:(WeightUnits)units forDate:(NSDate *)date;
- (NSString *)stringForWeightInUnit:(WeightUnits)unit;

+ (NSString *)stringForRow:(NSInteger)row;

@end
