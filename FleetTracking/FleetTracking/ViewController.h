//
//  ViewController.h
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property(weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong, nonatomic) CLLocationManager *locationManager;

@end
