//
//  GetData.m
//  tutu
//
//  Created by Kirill Sapronov on 04.07.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "GetData.h"
#import "CJSONDeserializer.h"
NSCache *cashe;
@interface GetData ()

@end

@implementation GetData

- (NSCache *)cashe {
    if (!cashe)
        cashe = [NSCache new];
    return cashe;
}

-(void) getdata {
    //Запрос для получения информации
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.cashe setObject:requestReply forKey:@"request"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetDataProcessNotification" object:nil];
    }] resume];
}

-(void) parsedata {
    //Прасим полученую информацию
    NSString *jsonString = [cashe objectForKey:@"request"];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    [cashe setObject:dictionary forKey:@"request"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetDataProcessStop" object:nil];
}

@end
