//
//  FirstViewController.m
//  tutu
//
//  Created by Kirill Sapronov on 28.06.16.
//  Copyright © 2016 Kirill Sapronov. All rights reserved.
//

#import "FirstViewController.h"
#import "GetData.h"
#import "CJSONDeserializer.h"

NSString *CityOtpr;
NSString *CityPrib;
NSString *Vremy;

@interface FirstViewController ()
@property (nonatomic, readonly) GetData *data;
@property (nonatomic, readonly) NSOperationQueue *queue;
@end

@implementation FirstViewController
@synthesize queue = _queue;
@synthesize data = _data;
@synthesize ViborOut1;
@synthesize ViborOut2;
@synthesize VremOut;
@synthesize PribOut;
@synthesize OtprOut;
@synthesize VremLabOut;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if (![cashe objectForKey:@"request"]) {
        [self.view addSubview: activityView];
        activityView.center = self.view.center;
        self.ViborOut1.enabled = false;
        self.ViborOut2.enabled = false;
        self.VremOut.enabled = false;
        [activityView startAnimating];
        //Открытие потока для загрзки данных
        [self.queue addOperationWithBlock:^{
            [self.data getdata];
        }];
    }
    //Уведомление о получении информации
    [[NSNotificationCenter defaultCenter] addObserverForName:GetDataProcessNotification object:nil queue:nil usingBlock:^(NSNotification * __nonnull note){
        [self.data parsedata];
    }];
    //Уведомление о окончании парсинга
    [[NSNotificationCenter defaultCenter] addObserverForName:GetDataProcessStop object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __nonnull note){
        self.ViborOut1.enabled = true;
        self.ViborOut2.enabled = true;
        self.VremOut.enabled = true;
        [activityView stopAnimating];
    }];
    if (![[NSString stringWithFormat:@"%@", CityOtpr] isEqualToString:@""]) {
        for (id cityName in [[cashe objectForKey:@"request"] objectForKey:@"citiesFrom"]) {
            for (id station in [cityName objectForKey:@"stations"]) {
                if ([[NSString stringWithFormat:@"%@", [station objectForKey:@"stationId"]] isEqualToString:[NSString stringWithFormat:@"%@", CityOtpr]]) {
                    self.OtprOut.text = [NSString stringWithFormat:@"%@", [station objectForKey:@"stationTitle"]];
                }
            }
        }
    }
    if (![[NSString stringWithFormat:@"%@", CityPrib] isEqualToString:@""]) {
        for (id cityName in [[cashe objectForKey:@"request"] objectForKey:@"citiesTo"]) {
            for (id station in [cityName objectForKey:@"stations"]) {
                if ([[NSString stringWithFormat:@"%@", [station objectForKey:@"stationId"]] isEqualToString:[NSString stringWithFormat:@"%@", CityPrib]]) {
                    self.PribOut.text = [NSString stringWithFormat:@"%@", [station objectForKey:@"stationTitle"]];
                }
            }
        }
    }
    if (![[NSString stringWithFormat:@"%@", Vremy] isEqualToString:@""]) {
        self.VremLabOut.text = Vremy;
    }
}


- (GetData *)data {
    if (!_data)
        _data = [GetData new];
    return _data;
}
- (NSOperationQueue *)queue {
    if (!_queue)
        _queue = [NSOperationQueue new];
    return _queue;
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
