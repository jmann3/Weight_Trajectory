//
//  HistoryCell.m
//  WeightData
//
//  Created by John Mann on 10/26/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithWeightEntry:(WeightEntry *)entry defaultUnits:(WeightUnits)unit {
    self.weightLabel.text = [entry stringForWeightInUnit:unit];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:entry.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
}

@end
