//
//  UserLocationFinder.m
//  ACSProduct
//
//  Created by preet dhillon on 22/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "UserLocationFinder.h"

@implementation UserLocationFinder
@synthesize strUserLat,strUserLong;
-(void)findCurrentLocation
{
    _stopUp = 1;
    locmanager = [[CLLocationManager alloc] init];
	[locmanager setDelegate:self];
	[locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
	[locmanager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(_stopUp == 1)
    {
        _stopUp = 0;
        ////NSLog(@"%g",newLocation.coordinate.latitude);
        
        // Log the kind of accuracy we got from this
        [locmanager stopUpdatingLocation];
        self.strUserLat = [NSString stringWithFormat:@"%g",newLocation.coordinate.latitude];
        self.strUserLong = [NSString stringWithFormat:@"%g",newLocation.coordinate.longitude];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [locmanager stopUpdatingLocation];
}

@end
