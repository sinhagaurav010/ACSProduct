//
//  CustomMapView.h
//  GolfPilot
//
//  Created by gaurav on 28/06/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "iCodeBlogAnnotationView.h"

@protocol customMapvViewDelegate <NSObject>
@optional
-(void)clickAtindex:(NSInteger)index;
@end

@interface CustomMapView : MKMapView<MKMapViewDelegate> {
    id<customMapvViewDelegate>client;
    MKReverseGeocoder *geoCoder;
    MKPlacemark *mPlacemark;
    CLLocationCoordinate2D location;
    MyAnnotation *addAnnotation;
    MKCoordinateRegion region;
	MKCoordinateSpan span;   
}
-(void)customizeMap:(NSMutableArray*)arrayWellData;

@property (retain)	id <customMapvViewDelegate> client;
@end
