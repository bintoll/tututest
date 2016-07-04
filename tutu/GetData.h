//
//  GetData.h
//  tutu
//
//  Created by Kirill Sapronov on 04.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GetDataProcessNotification @"GetDataProcessNotification"
#define GetDataProcessStop @"GetDataProcessStop"


@interface GetData : NSObject
- (void)getdata;
- (void)parsedata;
extern NSCache *cashe;
@end
