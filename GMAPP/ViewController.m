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
    
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:@"F7462DE1-FF00-AF9A-ECB9-99CD57B8BD60"];
    
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"hjs"];
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
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
}
@end
