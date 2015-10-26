//
//  ViewController.m
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  CLAuthorizationStatus autorizationStatus =
      [CLLocationManager authorizationStatus];

  if (autorizationStatus == kCLAuthorizationStatusRestricted ||
      autorizationStatus == kCLAuthorizationStatusDenied) {
    NSLog(@"Restricted or denied access to location services");
  } else {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    if (autorizationStatus == kCLAuthorizationStatusNotDetermined) {
      [self.locationManager requestAlwaysAuthorization];
    } else {
      [self.locationManager startUpdatingLocation];
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// pragma - mark LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didChangeAuthorizationStatus:(CLAuthorizationStatus)autorizationStatus {

  NSLog(@"Authorization status updated");
  if (autorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
    [self.locationManager startUpdatingLocation];
  }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {

  NSLog(@"Location updated");

  [locations
      enumerateObjectsUsingBlock:^(CLLocation *__nonnull location,
                                   NSUInteger idx, BOOL *__nonnull stop) {
        CLLocationCoordinate2D coordinates = location.coordinate;
        NSLog(@"latitude: %f longitude: %f", coordinates.latitude,
              coordinates.longitude);

      }];
}

@end
