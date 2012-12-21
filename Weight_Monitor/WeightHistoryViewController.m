//
//  WeightHistory1ViewController.m
//  WeightData
//
//  Created by John Mann on 10/26/12.
//  Copyright (c) 2012 John Mann. All rights reserved.
//

#import "WeightHistoryViewController.h"
#import "HistoryCell.h"
#import "DetailViewController.h"

@interface WeightHistoryViewController ()
//- (void)reloadTableData;
//- (void)weightHistoryChanged:(NSDictionary *)change;
@end

@implementation WeightHistoryViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)awakeFromNib {
    
    self.weights = [[NSMutableArray alloc] init];
    sharedDataStore = [DataStore sharedStore];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // create observer for notifications
    //[self.weights addObserver:self forKeyPath:@"KVOWeightChangeKey" options:NSKeyValueObservingOptionNew context:nil];
    
    // register to receive notifications
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableData) name:@"WeightHistoryChanged" object:self.weights];
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"number of weights entered is %d", self.weights.count);
    
    return [sharedDataStore.weights count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"History Cell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    WeightEntry *entry = [sharedDataStore.weights objectAtIndex:indexPath.row];
    [cell configureWithWeightEntry:entry defaultUnits:entry.units];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [sharedDataStore.weights removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    selectedIndex = indexPath;
   
    [self performSegueWithIdentifier:@"Detail Weight" sender:self];
}

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

#pragma mark methods to allow EnterWeightViewController to add weights

- (void)addWeight:(WeightEntry *)entry {
    if (entry) {
        [self.weights addObject:entry];
        
        [sharedDataStore.weights addObject:entry];
    }
    //NSLog(@"number of weights in table is %d", [self.weights count]);
    [self.tableView reloadData];
}

#pragma mark prepare for segue and set index

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detail Weight"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        //detailViewController.selectedIndex = [self.tableView indexPathForSelectedRow];
        detailViewController.selectedIndex = selectedIndex;
    }
}



@end
