//
//  ViewController.h
//  GMAPP
//
//  Created by hjs6877 on 5/1/14.
//  Copyright (c) 2014 황정식. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet CLBeaconRegion* myBeaconRegion;
@property (strong, nonatomic) IBOutlet CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UILabel *beconStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelMode;
@property (weak, nonatomic) IBOutlet UISwitch *btnSwitch;
- (IBAction)touchSwitch:(id)sender;

@end
