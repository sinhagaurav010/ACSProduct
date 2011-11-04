//
//  MapViewController.h
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMapView.h"
#import "DetailsViewController.h"
@interface MapViewController : UIViewController<customMapvViewDelegate> {
    CustomMapView   *customMap;
    NSMutableArray *arrayLatLong;
    
}
@property(retain)NSMutableArray *arrayMapLocs;
@property(assign)BOOL isFromDetail;
@end
