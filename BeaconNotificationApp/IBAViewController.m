//
//  IBAViewController.m
//  BeaconNotificationApp
//
//  Created by shn on 2014/06/02.
//  Copyright (c) 2014年 pollseed. All rights reserved.
//

#import "IBAViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface IBAViewController () <CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CBPeripheralManager *peripheralManager;
@property (nonatomic) NSUUID *proximityUUID;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) CLBeacon *nearestBeacon;

@end

@implementation IBAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 生成したUUID -> NSUUID
    self.proximityUUID = [[NSUUID alloc] initWithUUIDString:@"79D2AA27-F2F3-477A-BA0E-A3AF88FB8CA1"];
    
    // CBPeripheralManager作成
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    // アドバタイズ開始
    if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn)
    {
        [self startAdvertising];
    }
}

- (void)startAdvertising
{
    //CLBeaconRegionを作成->アドバタイズするデータを取得
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID major:1 minor:2 identifier:@"jp.classmethod.testregion"];
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    // アドバタイズを開始
    [self.peripheralManager startAdvertising:beaconPeripheralData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
