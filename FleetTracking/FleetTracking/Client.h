//
//  Client.h
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Client : NSObject

+ (void)updateLocationWithCoordinates:(CLLocationCoordinate2D)coord;

@end