//
//  CustomCell.m
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "CustomCell.h"
#import "GetData.h"

@implementation CustomCell
@synthesize NameLabel = _NameLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.NameLabel = (UILabel *)[self viewWithTag:0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
