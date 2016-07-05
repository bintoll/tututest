//
//  DetailInfoViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 05.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "FirstViewController.h"
#import "GetData.h"

@interface DetailInfoViewController ()
@property (nonatomic, readonly) NSString *titleViewController;
@end

@implementation DetailInfoViewController
@synthesize Strana;
@synthesize Gorod;
@synthesize Nazvan;
@synthesize titleViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleViewController = [self backViewController];
    NSString *statid;
    statid = [NSString new];
    if ([[self backViewController] isEqualToString:@"OtprStat"]) {
        statid = [NSString stringWithFormat:@"%@", CityOtpr];
        titleViewController = @"citiesFrom";
    } else if ([[self backViewController] isEqualToString:@"PribStat"]) {
        statid = [NSString stringWithFormat:@"%@", CityPrib];
        titleViewController = @"citiesTo";
    }
    for (id cityName in [[cashe objectForKey:@"request"] objectForKey:titleViewController]) {
        for (id station in [cityName objectForKey:@"stations"]) {
            if ([[NSString stringWithFormat:@"%@", [station objectForKey:@"stationId"]] isEqualToString:statid]) {
                self.Strana.text = [cityName objectForKey:@"countryTitle"];
                self.Gorod.text = [station objectForKey:@"cityTitle"];
                self.Nazvan.text = [station objectForKey:@"stationTitle"];
            }
        }
    }
}

- (NSString *) titleViewController {
    if (!titleViewController)
        titleViewController = [NSString new];
    return titleViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2].title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Select:(id)sender {
    [self performSegueWithIdentifier:@"GoToMain" sender:self];
}
@end
