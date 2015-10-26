//
//  Client.m
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import "Client.h"
#import <AFHTTPRequestOperationManager.h>

#define kApiRoot @"http://example.com/resources.json"

@interface Client ()

@end

@implementation Client

+ (void)updateLocationWithCoordinates:(CLLocationCoordinate2D)coord {
  AFHTTPRequestOperationManager *manager =
      [AFHTTPRequestOperationManager manager];

  NSDictionary *parameters = @{
    @"longitude" : @(coord.longitude),
    @"latitude" : @(coord.latitude)
  };

  [manager POST:kApiRoot
      parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
      }];
}

@end