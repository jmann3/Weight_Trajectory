//
//  DetailViewController.m
//  WeightData
//
//  Created by Arielle Mann on 10/30/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    
    WeightEntry *entry = [sharedDataStore.weights objectAtIndex:self.selectedIndex.row];
    WeightUnits unit = entry.units;
    
    //CGFloat weight = entry.weight;
    
    NSDate *startOfMonth;
    NSTimeInterval monthLength;
    [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startOfMonth interval:&monthLength forDate:entry.date];
    
    CGFloat minWeight = CGFLOAT_MAX;
    CGFloat maxWeight = CGFLOAT_MIN;
    int monthlyCount = 0;
    CGFloat monthlyTotal = 0.0f;
    for (WeightEntry *otherEntry in sharedDataStore.weights) {
        CGFloat sampleWeight = [self correctedWeight:otherEntry.weight InUnits:unit fromUnits:otherEntry.units];
        
        if (sampleWeight < minWeight) {
            minWeight = sampleWeight;
        }
        if (sampleWeight > maxWeight) {
            maxWeight = sampleWeight;
        }
        
        // check if it's in the same month
        NSTimeInterval timeFromStartOfMonth = [otherEntry.date timeIntervalSinceDate:startOfMonth];
        if (timeFromStartOfMonth > 0 && timeFromStartOfMonth < monthLength) {
            monthlyTotal += sampleWeight;
            monthlyCount++;
        }
    }
    CGFloat monthlyAverage = monthlyTotal / (float)monthlyCount;
    
    // fill in tableview values
    self.weightTextField.text = [NSString stringWithFormat:@"%.02f %@", entry.weight, [WeightEntry stringForRow:entry.units]];
    
    if (entry.weight > monthlyAverage) {
        self.weightTextField.textColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1.0];
    }
    
    self.dateTextField.text = [NSDateFormatter localizedStringFromDate:entry.date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    self.averageTextField.text = [NSString stringWithFormat:@"%.02f %@", monthlyAverage,
                                  entry.units ==  0 ? @"lbs" : @"Kg"];
    
    self.lossTextField.text = [NSString stringWithFormat:@"%.02f %@", maxWeight - entry.weight,
                               entry.units ==  0 ? @"lbs" : @"Kg"];
    
    self.gainTextField.text = [NSString stringWithFormat:@"%.02f %@", entry.weight - minWeight,
                               entry.units ==  0 ? @"lbs" : @"Kg"];
}

 
- (void)awakeFromNib {
    
    sharedDataStore = [DataStore sharedStore];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)correctedWeight:(CGFloat)weight InUnits:(WeightUnits)referenceUnits fromUnits:(WeightUnits)currentUnits {
    
    if (referenceUnits != currentUnits) {
        if (referenceUnits == 0) {
            weight = weight * 2.204;
        } else {
            weight = weight / 2.204;
        }
    }
    
    return weight;
}

@end
