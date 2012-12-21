//
//  HistoryCell.h
//  WeightData
//
//  Created by John Mann on 10/26/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightEntry.h"


@interface HistoryCell : UITableViewCell {
    
}

@property (nonatomic, strong) IBOutlet UILabel *weightLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

- (void)configureWithWeightEntry:(WeightEntry *)entry defaultUnits:(WeightUnits)unit;

@end
