//
//  CustomMapView.m
//  GolfPilot
//
//  Created by gaurav on 28/06/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "CustomMapView.h"


@implementation CustomMapView
@synthesize client;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // self = [[MKMapView alloc]initWithFrame:frame];
        // Initialization code
    }
    return self;
}

-(void)customizeMap:(NSMutableArray*)arrayWellData
{
    //NSLog(@"count count%d",[arrayWellData count]);
    self.delegate = self;
    
    for(int i=0;i<[arrayWellData count];i++)
    {
        // [arrayWell addObject:[arrayWellData objectAtIndex:i]];
        ////NSLog(@"%@",arrayWellData);
        location.latitude = [[[arrayWellData objectAtIndex:i] objectForKey:FIELDLAT] floatValue];
        location.longitude = [[[arrayWellData objectAtIndex:i] objectForKey:FIELDLONG] floatValue];
        //////NSLog(@"%f",location.latitude);
        
        span.latitudeDelta=0.06;
        span.longitudeDelta=0.06;
        region.span=span;
        


        //region.span=span;
        region.center=location;
        
        [self setRegion:region animated:YES];
        [self regionThatFits:region];
        self.showsUserLocation = TRUE;
        self.zoomEnabled = YES;
        
        if(addAnnotation!= nil)
            addAnnotation = nil;
        addAnnotation = [[MyAnnotation alloc] initWithCoordinate:location]  ;

        ///////Add new Code for the number of pin on the same point
        [addAnnotation setTitle:[[arrayWellData objectAtIndex:i]objectForKey:@"title"]];
       
        
//        if([[arrayWellData objectAtIndex:i]objectForKey:@"time"])
//        {
//            [addAnnotation setTitle:[[arrayWellData objectAtIndex:i]objectForKey:@"time"]];
//            if([[arrayWellData objectAtIndex:i]objectForKey:@"listmembers"])
//            {
//                if([[[arrayWellData objectAtIndex:i] objectForKey:@"listmembers"] objectForKey:@"member"])
//                {
//                    if([[[[arrayWellData objectAtIndex:i] objectForKey:@"listmembers"] objectForKey:@"member"]isKindOfClass:[NSArray class]])
//                        [addAnnotation  setSubtitle:[NSString stringWithFormat:@"Near Members %d",[[[[arrayWellData objectAtIndex:i] objectForKey:@"listmembers"] objectForKey:@"member"] count]]];
//                    else
//                         [addAnnotation  setSubtitle:[NSString stringWithFormat:@"Near Members 1"]];
//                }
//            }
//            else
//            {
//                [addAnnotation  setSubtitle:[NSString stringWithFormat:@"Near Members 0"]];
//            }
//            //[addAnnotation  setSubtitle:[NSString stringWithFormat:@"%d",i]];
//        }
//        else
//        {
//            [addAnnotation setTitle:@"N.A."];
//        }
        
        [addAnnotation setAnn_tag:i];
        
        [self addAnnotation:addAnnotation];
        //[addAnnotation release];
    }
    
}

- (MKAnnotationView*)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    ///////NSLog(@"hi i ma there");
    NSString *string   =   mPlacemark.locality;
    
	MKPinAnnotationView *annView = nil;
    
    if (annotation == self.userLocation) 
    {
        return nil;
    }
    
    
	annView = (MKPinAnnotationView *)[self dequeueReusableAnnotationViewWithIdentifier:string];
	MyAnnotation *annot = (MyAnnotation*)annotation;
	// If we have to, create a new view
	if(annView == nil)
    {
        // ////NSLog(@"here");
        annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:string] autorelease];
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //annView.tag = annot.ann_tag;
    }
    //MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:string];  
	
	annView.canShowCallout = YES;  
	
	//[annView setSelected:YES];  	
	
    //annView.rightCalloutAccessoryView = 
	[annView setPinColor:MKPinAnnotationColorGreen];
	
	annView.calloutOffset = CGPointMake(-5, 5);
	annView.animatesDrop=TRUE; 
	return annView;
    
    ///////To add image in the annotation
    
    //    if (annotation == mapView.userLocation) 
    //    {
    //        return annotationView;
    //    }
    //    
    //    NSString *string   =   mPlacemark.locality;
    //    MKPinAnnotationView *annView = nil;
    //    
    //    MyAnnotation* myAnnotation = (MyAnnotation *)annotation;
    //    
    //    annView = (MKPinAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:string];
    //    
    //    //[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:string] autorelease];
    //    
    //    NSString* identifier =@"cell";
    //    
    //    iCodeBlogAnnotationView *newAnnotationView = (iCodeBlogAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
    //    
    //    //	//////NSLog(@"myann");
    //    if(  nil == newAnnotationView)
    //    {
    //        //////NSLog(@"enter");
    //        newAnnotationView = [[iCodeBlogAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];
    //        newAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //    }
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MyAnnotation *ann = (MyAnnotation*)[view annotation];
    int loc1  = ann.ann_tag;
    if ([self.client  respondsToSelector:@selector(clickAtindex:)])
        [self.client clickAtindex:loc1];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    [super dealloc];
}

@end
