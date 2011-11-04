//
//  MapViewController.m
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize arrayMapLocs,isFromDetail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)Direction
{
  
    NSString *stringURL = [NSString stringWithFormat:LINKMAPURL,locationUser.strUserLat,locationUser.strUserLong,[[arrayLatLong objectAtIndex:0] objectForKey:FIELDLAT],[[arrayLatLong objectAtIndex:0] objectForKey:FIELDLONG]];
    NSLog(@"%@",stringURL);
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
    
    //    NSString *latlong = [NSString stringWithFormat:@"%@%@",[dictDetails objectForKey:@"lat"],[dictDetails objectForKey:@"lng"]];
    //    
    //    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?ll=%@",
    //                     [latlong stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    //    NSString *address = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",textAddress.text];
    //    NSString *escaped_address =  [address stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:escaped_address]];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor] ];

    [self.navigationItem setTitle:MAPTITLE];
    
    
    customMap = [[CustomMapView alloc] initWithFrame:self.view.bounds];
    customMap.client = self;	
    customMap.mapType = MKMapTypeStandard;
    
    customMap.showsUserLocation = YES;
    [self.view insertSubview:customMap atIndex:1];

    
    //[self functionToCheckLat:arrayMapContent]];

    arrayLatLong = [[NSMutableArray alloc] init];
    
    if(isFromDetail == 0)
    {
        arrayMapLocs = [[NSMutableArray alloc] initWithArray:arrayAllData];
    }
    for(int i=0;i<[arrayMapLocs count];i++)
    {
        NSMutableDictionary *dictLong = [[NSMutableDictionary alloc] init];
        [dictLong setObject:[[arrayMapLocs objectAtIndex:i ]objectForKey:FIELDLAT] forKey:FIELDLAT];
        [dictLong setObject:[[arrayMapLocs objectAtIndex:i ]objectForKey:FIELDLONG] forKey:FIELDLONG];
        [dictLong setObject:[[arrayMapLocs objectAtIndex:i ]objectForKey:FIELDNAME] forKey:@"title"];

        [arrayLatLong addObject:dictLong];
        [dictLong release];
    }
    
    if(self.isFromDetail == 1)
    {
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Get Direction" 
                                                                style:UIBarButtonItemStyleDone 
                                                               target:self 
                                                               action:@selector(Direction)];
        self.navigationItem.rightBarButtonItem = btn;
        [btn release];

    }
    
    [customMap customizeMap:arrayLatLong];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)clickAtindex:(NSInteger)index
{
    if(self.isFromDetail == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        DetailsViewController  *detailController = [[DetailsViewController alloc] init];
        detailController.dictInfo = [arrayMapLocs objectAtIndex:index];
        detailController.isFromFav = 0;
        [self.navigationController pushViewController:detailController animated:YES];
        [detailController release];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
