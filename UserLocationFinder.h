//
//  UserLocationFinder.h
//  ACSProduct
//
//  Created by preet dhillon on 22/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocationFinder : NSObject<CLLocationManagerDelegate>
{
    BOOL _stopUp;
    CLLocationManager *locmanager;
}
-(void)findCurrentLocation;

@property(retain)NSString *strUserLat;
@property(retain)NSString *strUserLong;
@end
