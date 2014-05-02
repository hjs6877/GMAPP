//
//  ViewController.m
//  GMAPP
//
//  Created by hjs6877 on 5/1/14.
//  Copyright (c) 2014 황정식. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:0 minor:0 identifier:@"hjs"];
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
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

- (IBAction)touchSwitch:(id)sender {
    if ([_btnSwitch isOn]) {
        NSLog(@"Switch on!!");
        _labelMode.text = @"On";
    }else{
        NSLog(@"Switch off!!");
        _labelMode.text = @"Off";
    }
}

/*
- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    self.beconStatusLabel.text = @"Off";
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    
    self.beconStatusLabel.text = @"On";
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
    
    NSLog(@"uuid: %@", uuid);
    NSLog(@"major: %@", major);
    NSLog(@"minor: %@", minor);
    
    NSLog(@"locationManager 메서드 호출!!");
    if([beacons count] > 0){
        NSLog(@"감지된 비콘이 있음");
    }else{
        NSLog(@"현재 범위에 비콘이 존재 하지 않음.");
    }
}
 */

/*
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
    // handle notifyEntryStateOnDisplay
    // notify user they have entered the region, if you haven't already
    if (manager == self.locationManager &&
        [region.identifier isEqualToString:kUniqueRegionIdentifier] &&
        state == CLRegionStateInside &&
        !self.didShowEntranceNotifier) {
        
        // start beacon ranging
        [self startBeaconRanging];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    // handle notifyOnEntry
    // notify user they have entered the region, if you haven't already
    if (manager == self.locationManager &&
        [region.identifier isEqualToString:kUniqueRegionIdentifier] &&
        !self.didShowEntranceNotifier) {
        
        // start beacon ranging
        [self startBeaconRanging];
    }
}
*/
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"타겟 범위에서 떠났습니다.");
    // optionally notify user they have left the region
    /*
    if (!self.didShowExitNotifier) {
        
        self.didShowExitNotifier = YES;
        
        // fire notification with region update
        [self fireUpdateNotificationForStatus:@"Thanks for visiting.  You have now left the target region."];
    }
    
    // reset entrance notifier
    self.didShowEntranceNotifier = NO;
    
    // stop beacon ranging
    [manager stopRangingBeaconsInRegion:[CSMBeaconRegion targetRegion]];
    */
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    // identify closest beacon in range
    if ([beacons count] > 0) {
        CLBeacon *closestBeacon = beacons[0];
        if (closestBeacon.proximity == CLProximityImmediate) {
 
            // Provide proximity based information to user.  You may choose to do this repeatedly
            // or only once depending on the use case.  Optionally use major, minor values here to provide beacon-//specific content
 
            //[self fireUpdateNotificationForStatus:@"현재 Beacon에 가장 근접해있습니다."];
            NSLog(@"현재 Beacon에 근접해있습니다.");
            
        } else if (closestBeacon.proximity == CLProximityNear) {
            // detect other nearby beacons
            // optionally hide previously displayed proximity based information
            //[self fireUpdateNotificationForStatus:@"Beacon이 가까이에 있습니다."];
            NSLog(@"Beacon이 현재 당신 가까이에 있습니다.");
        }
    } else {
        // no beacons in range - signal may have been lost
        // optionally hide previously displayed proximity based information
        //[self fireUpdateNotificationForStatus:@"현재 범위내에 어떤 Beacon도 없습니다."];
        NSLog(@"현재 범위내에 해당 Beacond이 없습니다.");
    }
}

/* 
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    
    // fire notification of range failure
    [self fireUpdateNotificationForStatus:[NSString stringWithFormat:@"Beacon ranging 범위 측정에서 에러가 발생함: %@", error]];
    
    // assume notifications failed, reset indicators
    self.didShowEntranceNotifier = NO;
    self.didShowExitNotifier = NO;
}
*/
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"현재 비콘을 모니터링 중입니다.");
    // fire notification of region monitoring
    //[self fireUpdateNotificationForStatus:[NSString stringWithFormat:@"현재 Beaon을 모니터링 중입니다.: %@",((CLBeaconRegion*)region).identifier]];
}

/*
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    
    // fire notification with status update
    [self fireUpdateNotificationForStatus:[NSString stringWithFormat:@"Beacon 모니터링중 에러 발생: %@", error]];
    
    // assume notifications failed, reset indicators
    self.didShowEntranceNotifier = NO;
    self.didShowExitNotifier = NO;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    // current location usage is required to use this demo app
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        [[[UIAlertView alloc] initWithTitle:@"Current Location Required"
                                    message:@"Please re-enable Core Location to run this Demo.  The app will now exit."
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
    }
}
*/
@end
