//
//  DealsInfoViewController.m
//  ACSProduct
//
//  Created by preet dhillon on 16/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//
/*
 Address = "Lane 288 talking road,London";
 Cost = "120.00";
 Deal = "10%";
 DealDesc = "10% off in buisness special offer";
 DealExpires = 20Dec2011;
 Desc = "test london test london test london test london test london test london";
 Email = "info@acs.com";
 Images =         {
 Image =             (
 "http://www.urban75.org/london/images/shunt-club-london-bridge-09.jpg",
 ImageLink2,
 ImageLink3
 );
 };
 Lat = "51.505858";
 ListType = Cat;
 Loc = London;
 Long = "-0.150461";
 Name = "288 The Melting Point";
 Phone = 1234532;
 Type = "Clubs and Bar";
 URL = "http://www.acs.com";
*/
#import "DealsInfoViewController.h"

@implementation DealsInfoViewController
@synthesize dictDealInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [viewForWebView.layer setCornerRadius:35.0f];
    [viewForWebView.layer setMasksToBounds:YES];
    viewForWebView.backgroundColor = [UIColor clearColor];
    
    
    webViewInfo.backgroundColor = [UIColor clearColor];
    labelExp.text = [dictDealInfo objectForKey:FIELDDEALEXP];
    labelCost.text = [NSString stringWithFormat:@"%@€",[dictDealInfo  objectForKey:FIELDCOST]];
    labelOff.text =[NSString stringWithFormat:@"%@ off", [dictDealInfo   objectForKey:FIELDDEAL]];
    [webViewInfo loadHTMLString:[dictDealInfo objectForKey:FIELDDEALDES] baseURL:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
