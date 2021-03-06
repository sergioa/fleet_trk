//
//  ViewController.m
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"

#define kDistanceFilter 50.0

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

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
      [self trk_startUpdatingLocation];
    }
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma - mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didChangeAuthorizationStatus:(CLAuthorizationStatus)autorizationStatus {

  NSLog(@"Authorization status updated");
  if (autorizationStatus == kCLAuthorizationStatusAuthorizedAlways) {
    [self trk_startUpdatingLocation];
  }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {

  [locations enumerateObjectsUsingBlock:^(CLLocation *__nonnull location,
                                          NSUInteger idx,
                                          BOOL *__nonnull stop) {
    CLLocationCoordinate2D coordinates = location.coordinate;
    NSLog(@"latitude: %f longitude: %f", coordinates.latitude,
          coordinates.longitude);

    [self.mapView
        setRegion:MKCoordinateRegionMakeWithDistance(coordinates, 500, 500)];

    [Client updateLocationWithCoordinates:coordinates];

  }];
}

- (void)trk_startUpdatingLocation {
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
  self.locationManager.distanceFilter = kDistanceFilter;
  self.locationManager.allowsBackgroundLocationUpdates = YES;
  [self.locationManager startUpdatingLocation];
}

@end
