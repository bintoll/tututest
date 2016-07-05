//
//  DetailInfoViewController.h
//  tutu
//
//  Created by Kirill Sapronov on 05.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoViewController : UIViewController

- (NSString *)backViewController;

@property (weak, nonatomic) IBOutlet UILabel *Strana;
@property (weak, nonatomic) IBOutlet UILabel *Gorod;
@property (weak, nonatomic) IBOutlet UILabel *Nazvan;
- (IBAction)Select:(id)sender;

@end
