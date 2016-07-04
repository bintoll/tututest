//
//  PribStatTableTableViewController.h
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PribStatTableTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>


@property (nonatomic, strong) NSMutableArray * filteredItems;
@property (nonatomic, strong) UISearchController * searchController;


@end
