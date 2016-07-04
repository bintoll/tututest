//
//  OtprStatTableTableViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "OtprStatTableTableViewController.h"
#import "CustomCell.h"
#import "GetData.h"
#import "FirstViewController.h"

@interface OtprStatTableTableViewController ()
@property (nonatomic, readonly) NSMutableArray *NazvStant;
@property (nonatomic, readonly) NSMutableArray *SectionTitels;
@end

@implementation OtprStatTableTableViewController{
    NSString *searchString;
}
@synthesize NazvStant;
@synthesize filteredItems;
@synthesize searchController;
@synthesize SectionTitels;

- (NSMutableArray *) NazvStant {
    if (!NazvStant)
        NazvStant = [NSMutableArray new];
    return NazvStant;
}

- (NSMutableArray *) SectionTitels {
    if (!SectionTitels)
        SectionTitels = [NSMutableArray new];
    return SectionTitels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filteredItems = [[NSMutableArray alloc] init];
    for (id cityName in [[cashe objectForKey:@"request"] objectForKey:@"citiesFrom"]) {
        for (id station in [cityName objectForKey:@"stations"]) {
            [self.NazvStant addObject:[station objectForKey:@"stationTitle"]];
        }
        [self.filteredItems addObject:cityName];
    }
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.tableView setContentOffset:CGPointMake(0, self.searchController.searchBar.frame.size.height)];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [filteredItems count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = [NSString stringWithFormat:@"%@, %@", [[filteredItems objectAtIndex:section] objectForKey:@"countryTitle"], [[filteredItems objectAtIndex:section] objectForKey:@"cityTitle"]];
    return str;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[filteredItems objectAtIndex:section] objectForKey:@"stations"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    cell.NameLabel.text = [[[[filteredItems objectAtIndex:indexPath.section] objectForKey:@"stations"] objectAtIndex:indexPath.row] objectForKey:@"stationTitle"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    return cell.frame.size.height;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)SearchController {
    if (![searchController.searchBar.text isEqualToString:@""]) {
        [self.filteredItems removeAllObjects];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
        NSMutableArray *filteredstat = [NSMutableArray new];
        [filteredstat addObjectsFromArray:[NazvStant filteredArrayUsingPredicate:pred]];
        for (id cityName in [[cashe objectForKey:@"request"] objectForKey:@"citiesFrom"]) {
            for (id station in [cityName objectForKey:@"stations"]) {
                if ([filteredstat containsObject:[NSString stringWithFormat:@"%@", [station objectForKey:@"stationTitle"]]]) {
                    [self.filteredItems addObject:cityName];
                }
            }
        }
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityOtpr = [[[[filteredItems objectAtIndex:indexPath.section] objectForKey:@"stations"] objectAtIndex:indexPath.row] objectForKey:@"stationId"];
    [self performSegueWithIdentifier:@"GoToDetailsOtpr" sender:self];
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
