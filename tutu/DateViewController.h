//
//  DateViewController.h
//  tutu
//
//  Created by Kirill Sapronov on 05.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *Picker;
- (IBAction)Select:(id)sender;

@end
