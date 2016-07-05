//
//  OtprStatTableTableViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "StatTableTableViewController.h"
#import "CustomCell.h"
#import "GetData.h"
#import "FirstViewController.h"

@interface StatTableTableViewController ()
@property (nonatomic, readonly) NSMutableArray *NazvStant;
@property (nonatomic, readonly) NSMutableArray *SectionTitels;
@property (nonatomic, readonly) NSString *titleViewController;
@end

@implementation StatTableTableViewController{
    NSString *searchString;
}
@synthesize NazvStant;
@synthesize filteredItems;
@synthesize searchController;
@synthesize SectionTitels;
@synthesize titleViewController;

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

- (NSString *) titleViewController {
    if (!titleViewController)
        titleViewController = [NSString new];
    return titleViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[NSString stringWithFormat:@"%@", self.title] isEqualToString:@"OtprStat"]) {
        titleViewController = @"citiesFrom";
    } else if ([[NSString stringWithFormat:@"%@", self.title] isEqualToString:@"PribStat"]) {
        titleViewController = @"citiesTo";
    }
    filteredItems = [NSMutableArray new];
    for (id cityName in [[cashe objectForKey:@"request"] objectForKey:titleViewController]) {
        for (id station in [cityName objectForKey:@"stations"]) {
            [self.NazvStant addObject:[station objectForKey:@"stationTitle"]];
        }
        [filteredItems addObject:cityName];
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
        for (id cityName in [[cashe objectForKey:@"request"] objectForKey:titleViewController]) {
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
    if ([[NSString stringWithFormat:@"%@", self.title] isEqualToString:@"OtprStat"]) {
        CityOtpr = [[[[filteredItems objectAtIndex:indexPath.section] objectForKey:@"stations"] objectAtIndex:indexPath.row] objectForKey:@"stationId"];
    } else if ([[NSString stringWithFormat:@"%@", self.title] isEqualToString:@"PribStat"]) {
        CityPrib = [[[[filteredItems objectAtIndex:indexPath.section] objectForKey:@"stations"] objectAtIndex:indexPath.row] objectForKey:@"stationId"];
    }
    [self performSegueWithIdentifier:@"GoToDetails" sender:self];
}
@end
