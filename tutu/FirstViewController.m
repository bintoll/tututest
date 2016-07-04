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
NSString *CityVremy;

@interface FirstViewController ()
@property (nonatomic, readonly) GetData *data;
@property (nonatomic, readonly) NSOperationQueue *queue;
@end

@implementation FirstViewController
@synthesize queue = _queue;
@synthesize data = _data;
@synthesize ViborOut1;
@synthesize ViborOut2;
- (void)viewDidLoad {
    [super viewDidLoad];
    //Режим ожидания загрузки
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview: activityView];
    activityView.center = self.view.center;
    self.ViborOut1.enabled = false;
    self.ViborOut2.enabled = false;
    [activityView startAnimating];
    //Уседомление о згрузке данных
    [[NSNotificationCenter defaultCenter] addObserverForName:GetDataProcessNotification object:nil queue:nil usingBlock:^(NSNotification * __nonnull note){
        [self.data parsedata];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:GetDataProcessStop object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * __nonnull note){
        self.ViborOut1.enabled = true;
        self.ViborOut2.enabled = true;
        [activityView stopAnimating];
    }];
    //Открытие потока для загрзки данных
    [self.queue addOperationWithBlock:^{
        [self.data getdata];
    }];
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
    // Dispose of any resources that can be recreated.
}

@end
