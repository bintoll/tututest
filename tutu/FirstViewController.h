//
//  FirstViewController.h
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *ViborOut1;
@property (weak, nonatomic) IBOutlet UIButton *ViborOut2;
@property (weak, nonatomic) IBOutlet UIButton *VremOut;
@property (weak, nonatomic) IBOutlet UILabel *OtprOut;
@property (weak, nonatomic) IBOutlet UILabel *PribOut;
@property (weak, nonatomic) IBOutlet UILabel *VremLabOut;
extern NSString *CityOtpr;
extern NSString *CityPrib;
extern NSString *Vremy;
@end

