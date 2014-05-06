//
//  ViewController.m
//  GMAPP
//
//  Created by hjs6877 on 5/1/14.
//  Copyright (c) 2014 황정식. All rights reserved.
//

#import "ViewController.h"
#import "IvtInfoPopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:0 minor:0 identifier:@"hjs"];
    [self.locationManager stopMonitoringForRegion:self.myBeaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    
    NSLog(@"뷰 로딩!!");
    NSLog(@"%@", self.myBeaconRegion);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 
 */
- (IBAction)touchSwitch:(id)sender {
    // 재물조사 모드일 경우, Beacon을 모니터링한다.
    if ([_btnSwitch isOn]) {
        NSLog(@"Switch on!!");
        _labelMode.text = @"On";
        [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
        [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    }else{
        NSLog(@"Switch off!!");
        _labelMode.text = @"Off";
        [self.locationManager stopMonitoringForRegion:self.myBeaconRegion];
        [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
        self.beconStatusLabel.text = @"Beacon 모니터링을 종료했습니다.";
        NSLog(@"Beacon 모니터링을 종료했습니다.");    }
}


- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
    self.beconStatusLabel.text = @"환영합니다! 타겟 Beacon안에 들어왔습니다.";
    NSLog(@"환영합니다! 타겟 beacon안에 들어왔습니다.");
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    
    self.beconStatusLabel.text =@"타겟 Beacon 범위에서 떠났습니다.";
    NSLog(@"타겟 범위에서 떠났습니다.");
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
    
    NSLog(@"uuid: %@", uuid);
    NSLog(@"major: %@", major);
    NSLog(@"minor: %@", minor);
    
    // identify closest beacon in range
    if ([beacons count] > 0) {
        CLBeacon *closestBeacon = beacons[0];
        if (closestBeacon.proximity == CLProximityImmediate) {
            self.beconStatusLabel.text = @"현재 Beacon에 근접(immediate)해있습니다.";
            NSLog(@"현재 Beacon에 근접(immediate)해있습니다.");
            
        } else if (closestBeacon.proximity == CLProximityNear) {
            self.beconStatusLabel.text = @"현재 Beacon이 근처(nearby)에 있습니다.";
            NSLog(@"현재 Beacon이 근처(nearby)에 있습니다.");
            
            IvtInfoPopupViewController* ivtInfoPopup = [self.storyboard instantiateViewControllerWithIdentifier:@"IvtInfoPopupViewController"];
            [self presentViewController:ivtInfoPopup animated:YES completion:NULL];
        }
    } else {
        self.beconStatusLabel.text = @"현재 범위내에 해당 Beacon이 없습니다.";
        NSLog(@"현재 범위내에 해당 Beacon이 없습니다.");
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    self.beconStatusLabel.text = @"현재 Beacon을 모니터링 중입니다.";
    NSLog(@"현재 Beacon을 모니터링 중입니다.");
}

@end
