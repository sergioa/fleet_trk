//
//  Client.m
//  FleetTracking
//
//  Created by sergioa on 26/10/15.
//  Copyright © 2015 Telefonica I+D. All rights reserved.
//

#import "Client.h"
#import <AFHTTPRequestOperationManager.h>

#define uid @"1"
#define secret @"artero"

@interface Client ()

@end

@implementation Client

+ (void)updateLocationWithCoordinates:(CLLocationCoordinate2D)coord {

  NSString *url =
      [NSString stringWithFormat:@"https://www.ootoyasushi.com/"
                                 @"index.php?fc=module&module=deliverytracking&"
                                 @"controller=bikepositions&updatePosition&id=%"
                                 @"@&token=%@&lat=%f&lng=%f",
                                 uid, secret, coord.latitude, coord.longitude];

  AFHTTPRequestOperationManager *manager =
      [AFHTTPRequestOperationManager manager];

  [manager setSecurityPolicy:[self trk_securityPolicy]];

  [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
  [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];

  [manager GET:url
      parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
      }];
}

+ (AFSecurityPolicy *)trk_securityPolicy {
  AFSecurityPolicy *securityPolicy =
      [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  [securityPolicy setAllowInvalidCertificates:YES];
  [securityPolicy setValidatesDomainName:NO];
  return securityPolicy;
}

@end