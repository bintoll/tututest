//
//  DateViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 05.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "DateViewController.h"
#import "FirstViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController
@synthesize Picker;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *currentDate = [NSDate date];
    self.Picker.minimumDate = currentDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDate *date = [self.Picker date];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd MMMM 'at' HH:mm"];
    Vremy = [dateFormatter stringFromDate:date];
    [self performSegueWithIdentifier:@"GoToMain" sender:self];
}
@end
