//
//  OtprStatTableTableViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "OtprStatTableTableViewController.h"
#import "CustomCell.h"

@interface OtprStatTableTableViewController ()

@end

@implementation OtprStatTableTableViewController{
    NSString *searchString;
}
@synthesize citys;
@synthesize filteredItems;
@synthesize searchController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citys = [[NSMutableArray alloc] init];
    [self.citys addObject:@"Apples"];
    [self.citys addObject:@"Oranges"];
    [self.citys addObject:@"Pears"];
    [self.citys addObject:@"Grapes"];
    [self.citys addObject:@"Grapefruits"];
    [self.citys addObject:@"Lemons"];
    [self.citys addObject:@"Peaches"];
    [self.citys addObject:@"Pineapples"];
    [self.citys addObject:@"Cherries"];
    [self.citys addObject:@"Bananas"];
    [self.citys addObject:@"Watermelons"];
    [self.citys addObject:@"Cantaloupes"];
    [self.citys addObject:@"Limes"];
    [self.citys addObject:@"Strawberries"];
    [self.citys addObject:@"Blueberries"];
    [self.citys addObject:@"Raspberries"];
    self.filteredItems = [[NSMutableArray alloc] init];
    [self.filteredItems addObjectsFromArray:citys];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    
    [self.searchController.searchBar sizeToFit];
    
    // Add the UISearchBar to the top header of the table view
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Hides search bar initially.  When the user pulls down on the list, the search bar is revealed.
    [self.tableView setContentOffset:CGPointMake(0, self.searchController.searchBar.frame.size.height)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.filteredItems.count;
    }
    else {
        return self.citys.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];

    // Configure the cell...
    if (self.searchController.active) {
        cell.NameLabel.text = [self.filteredItems objectAtIndex:indexPath.row];
        
        return cell;
    }
    else {
        cell.NameLabel.text = [self.citys objectAtIndex:indexPath.row];
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    return cell.frame.size.height;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)SearchController {
    NSLog(@"updateSearchResultsForSearchController");
    if (![searchController.searchBar.text isEqualToString:@""]) {
        [self.filteredItems removeAllObjects];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
        NSLog(@"%@", pred);
        [self.filteredItems addObjectsFromArray:[self.citys filteredArrayUsingPredicate:pred]];
        NSLog(@"%@", filteredItems);
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //_selectedCell = [aTableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%ld", (long)indexPath.row);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
