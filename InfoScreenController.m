//
//  InfoScreenController.m
//  City Guide
//
//  Created by Gaurav Sinha on 27/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfoScreenController.h"
#import "HomePageController.h"
//#import "ListViewController.h"
//#import "NearbyListController.h"
//#import "MetroViewController.h"

@implementation InfoScreenController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// Hide the navigation bar back button
	self.navigationItem.hidesBackButton = YES;
	
	UIButton* doneButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 25.0, 60, 32)];
	[doneButton setBackgroundImage:[UIImage imageNamed:@"done.png"] forState:UIControlStateNormal];
	[doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
	
	if (doneButton) {
		[doneButton release];
		doneButton = nil;
	}
	
	infoScroll.layer.cornerRadius = 15;
	infoScroll.layer.borderWidth = 2.0; 
	infoScroll.layer.borderColor = [[UIColor whiteColor] CGColor];
	infoScroll.backgroundColor = [UIColor whiteColor];
	
	//////////////////////
	// For Km Selcton and unselection
	[KMSelectButton setBackgroundImage:[UIImage imageNamed:@"km_o.png"] forState:UIControlStateSelected];
	[KMSelectButton setBackgroundImage:[UIImage imageNamed:@"km.png"] forState:UIControlStateNormal];

	//////////////////////
	// Mile selection and unselection
	[mileSelectButton setBackgroundImage:[UIImage imageNamed:@"miles.png"] forState:UIControlStateNormal];
	[mileSelectButton setBackgroundImage:[UIImage imageNamed:@"mile_o.png"] forState:UIControlStateSelected];

	
	[super viewDidLoad];
	[self infoScreen];	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)doneButtonClick:(id)sender
{
	
//	HomePageController *homeObj = (HomePageController*)[[[[self.tabBarController viewControllers] objectAtIndex:0] viewControllers]objectAtIndex:0];
//	[homeObj.myListObj reloadListTable];
//	
//	ListViewController *listObj = (ListViewController*)[[[[self.tabBarController viewControllers] objectAtIndex:1] viewControllers]objectAtIndex:0];
//	[listObj reloadListTable];
//
//	
//	NearbyListController *nearByObj = (NearbyListController*)[[[[self.tabBarController viewControllers] objectAtIndex:2] viewControllers]objectAtIndex:0];
//	[nearByObj reloadNearbyTable];
//	
//	ListViewController *dealsObj = (ListViewController*)[[[[self.tabBarController viewControllers] objectAtIndex:3] viewControllers]objectAtIndex:0];
//	[dealsObj reloadListTable];
//	
	//MetroViewController *metroObj = (MetroViewController*)[[[[self.tabBarController viewControllers] objectAtIndex:3] viewControllers]objectAtIndex:0];
	//[metroObj reloadMetroTable];
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	[[self navigationController] popViewControllerAnimated:NO];
	[UIView commitAnimations];
	
	//[self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)KMSelectButtonClicked:(id)sender{
	
	
	 KMselect = TRUE;
	// [KMSelectButton setBackgroundImage:[UIImage imageNamed:@"km_o.png"] forState:UIControlStateNormal];
	 //[mileSelectButton setBackgroundImage:[UIImage imageNamed:@"miles.png"] forState:UIControlStateNormal];
	// [nearByListable		reloadData];
	 //[venue_list_table	reloadData];
	KMSelectButton.selected		= 1;
	mileSelectButton.selected	= 0;
	 
	 if ([[NSUserDefaults standardUserDefaults]objectForKey:@"DistanceParameterSelect"])
	 {
	 [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DistanceParameterSelect"]; 
	 }	
	NSUserDefaults			*distance = [NSUserDefaults standardUserDefaults];
	[distance setBool:KMselect forKey:@"DistanceParameterSelect"];
	[distance synchronize];
	
	 
}


-(IBAction)mileSelectButtonClicked:(id)sender{
	
	 
	 KMselect =FALSE;
	// [KMSelectButton setBackgroundImage:[UIImage imageNamed:@"km.png"] forState:UIControlStateNormal];
	 //[mileSelectButton setBackgroundImage:[UIImage imageNamed:@"mile_o.png"] forState:UIControlStateNormal];
	 //[nearByListable		reloadData];
	 //[venue_list_table	reloadData];
	
	KMSelectButton.selected		= 0;
	mileSelectButton.selected	= 1;

	 
	 if ([[NSUserDefaults standardUserDefaults]objectForKey:@"DistanceParameterSelect"])
	 {
	 [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DistanceParameterSelect"]; 
	 }
	NSUserDefaults			*distance = [NSUserDefaults standardUserDefaults];
	[distance setBool:KMselect forKey:@"DistanceParameterSelect"];
	[distance synchronize];
	
	
}

-(IBAction)callButtonClicked:(id)sender{
	
	info_callAlert  = [[UIAlertView alloc] initWithTitle:nil message:DIAL_A_NUMBER delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[self.view addSubview:info_callAlert];
	[info_callAlert show];
	
	
}

-(IBAction)openURLButtonClicked:(id)sender{
	
	info_webLinkAlert  = [[UIAlertView alloc] initWithTitle:nil message:WEBLINK_VISIT delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[self.view addSubview:info_webLinkAlert];
	[info_webLinkAlert show];
	
}



-(IBAction)sendMailButtonClicked:(id)sender{
	
	
	MFMailComposeViewController *controller = [MFMailComposeViewController new];
	[controller setToRecipients:[NSArray arrayWithObjects:@"info@ACS.com",nil]];
	controller.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
	[controller setMessageBody:@"" isHTML:NO];
	[controller setMailComposeDelegate:self];
	[self presentModalViewController:controller animated:YES];
	[controller release];
	
	
}

#pragma mark Inforamation screen
-(void)infoScreen{
	
	//self.view.frame = CGRectMake(15.0, 90, self.view.bounds.size.width-30, (numberOfLinesOfInfoDescription + numberOfLinesOfQuality + numberOfLinesOfWho +  numberOfLinesOfWhat)*15 + 140);
	infoScroll.contentSize = CGSizeMake(305, 900);
		
	/////////////////////////////////////////////////////
	// Check that which button will be selected 
	if (KMselect == TRUE) {
		KMSelectButton.selected = 1;
		mileSelectButton.selected = 0;
	}
	else {
		KMSelectButton.selected = 0;
		mileSelectButton.selected = 1;
		
	}
	
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	KMSelectButton		= nil;
	mileSelectButton	= nil;
	callButton			= nil;
	openURLButton		= nil;
	sendMailButton		= nil;
	info_webLinkAlert	= nil;
	info_callAlert		= nil;
	info_mailAlert		= nil;
	infoScroll			= nil;
	
}


- (void)dealloc {
	
	[KMSelectButton		release];
	[mileSelectButton	release];
	[callButton			release];
	[openURLButton		release];
	[sendMailButton		release];
	[info_webLinkAlert	release];
	[info_callAlert		release];
	[info_mailAlert		release];
	[infoScroll			release];
	
    [super dealloc];
}


#pragma mark email delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	NSString *message = @"";
	if( MFMailComposeResultSent == result )
	{
		message = @"Mail sent OK";
	}
	else if( MFMailComposeResultCancelled == result )
	{
		
	}
	else
	{
		message = @"Mail sent failed";
	}
	if( [message length] > 0 )
	{
		//UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alertView show];
		//[alertView release];
	}
	[controller dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark  Alert View Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([alertView isEqual:info_callAlert]) {
		if (buttonIndex == 1){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://862164310265"]];
			
		}
		else {
			
		}	
		
	}
	
	
	else if ([alertView isEqual:info_webLinkAlert]) {
		if (buttonIndex == 1){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.shanghaiwow.com"]];
			
		}
		else {
			
		}	
		
	}

	
}

@end