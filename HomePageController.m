//
//  HomePageController.m
//  City Guide
//
//  Created by Gaurav Sinha on 27/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#define ALPHA	[@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "]

#import "HomePageController.h"
#import "InfoScreenController.h"
//#import "ListViewController.h"
//import "DatabaseHandler.h"
#import "HomePageCell.h"

@implementation HomePageController
@synthesize mySearchBar;
@synthesize myListObj,strListType;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
    }
    return self;
}


-(void)addobjINdictwithStringName:(NSString*)strName withImageName:(NSString*)strImage inArr:(BOOL)isInCat
{
    NSMutableDictionary *dictObj = [[NSMutableDictionary alloc] init];
    [dictObj setObject:strName forKey:@"name"];
    [dictObj setObject:strImage forKey:IMAGEDATAACS];
    
    if(isInCat==1)
        [catDataArray addObject:dictObj];
    else
        [tagDataArray addObject:dictObj];
    
    [dictObj release];
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.strListType = TYPECAT;
    
	/////////////////////////
	// Create the List view Object
	//////////////////////////////////////////////////////////////////////////
	// Fetch Category data
    
    //	dbHandlerObj = [[DatabaseHandler alloc]init];
    //	catDataArray =  [[dbHandlerObj fetchCategory_OR_TagData:[NSString stringWithFormat:@"Select * from %@ ORDER BY cat_name",CATEGORY_TABLE_NAME]] copy];
    //	
    //	//////////////////////////////////////////////////////////////////////////
    //	// Fetch Tag data
    //	tagDataArray = [[dbHandlerObj fetchCategory_OR_TagData:[NSString stringWithFormat:@"Select * from %@ ORDER BY tag_name",TAG_TABLE_NAME]] copy];
    
    //Title of the Page
    self.navigationItem.title = HOMETITLE;
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor] ];
    
    catDataArray = [[NSMutableArray alloc] init];
    
    [self addobjINdictwithStringName:@"Arts and Entertainment" withImageName:@"artsentertainment.png" inArr:1];
    [self addobjINdictwithStringName:@"Clubs and Bar" withImageName:@"bars.jpg" inArr:1];
    [self addobjINdictwithStringName:@"culture and history" withImageName:@"historyculture.png" inArr:1];
    [self addobjINdictwithStringName:@"Favourites" withImageName:@"favourites.jpg" inArr:1];
    [self addobjINdictwithStringName:@"health&beauty" withImageName:@"healthBeauty.jpg" inArr:1];
    [self addobjINdictwithStringName:@"Hotels" withImageName:@"hotel.gif" inArr:1];
    [self addobjINdictwithStringName:@"Museum" withImageName:@"museum.gif" inArr:1];
    [self addobjINdictwithStringName:@"Neighborhoods" withImageName:@"neighborhoods.gif" inArr:1];
    [self addobjINdictwithStringName:@"Parks" withImageName:@"park.jpg" inArr:1];
    [self addobjINdictwithStringName:@"Religion" withImageName:@"religion.png" inArr:1];
    [self addobjINdictwithStringName:@"Restaurants" withImageName:@"restaurants.gif" inArr:1];
    [self addobjINdictwithStringName:@"Shopping" withImageName:@"shopping.png" inArr:1];
    [self addobjINdictwithStringName:@"Tour" withImageName:@"tour.gif" inArr:1];
    
    tagDataArray = [[NSMutableArray alloc] init];
    
    [self addobjINdictwithStringName:@"Business" withImageName:@"business.jpg" inArr:0];
    [self addobjINdictwithStringName:@"Classic" withImageName:@"classic.jpg" inArr:0];
    [self addobjINdictwithStringName:@"Mansion" withImageName:@"mansion.png" inArr:0];
    [self addobjINdictwithStringName:@"Outdoor" withImageName:@"outdoor.png" inArr:0];
    [self addobjINdictwithStringName:@"Romantic" withImageName:@"romantic.jpg" inArr:0];
    
	commnArray = [catDataArray retain];
	///////////////////////////////////////////////////////////////////////////////////////////
	self.navigationItem.rightBarButtonItem = nil;
	
	// Add Info Button in the right side of the navigation bar
	UIButton *infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight]retain];
	[infoButton addTarget:self action:@selector(infoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	
	if (infoButton) {
		[infoButton release];
		infoButton = nil;
	}
	
	[mainTableView setBackgroundColor:[UIColor clearColor]]; // Set the background color of table view
	//////////////////////////////////////////////////////////////////////////
	// Used to set the category Button image on selection
	featureImage.alpha = 0.5;
	categoryImage.alpha = 1.0;
	
	
    [super viewDidLoad];
}

-(void)infoButtonClicked:(id)sender{
	
	//[self.view setBackgroundColor:BACKGROUND_COLOR];
	
	InfoScreenController *myInfoScreenController = [[InfoScreenController alloc]init];
	myInfoScreenController.hidesBottomBarWhenPushed = YES;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[[self navigationController] pushViewController:myInfoScreenController animated:NO];
	[UIView commitAnimations];
	
}
#pragma mark -
#pragma mark <Button Click Events>
-(IBAction)categoryButtonClicked:(id)sender{
	self.strListType = TYPECAT;
	WhichButtonClicked = 0;
	
	featureImage.alpha = 0.5;
	categoryImage.alpha = 1.0;
	
	commnArray = [catDataArray copy];
	
    //	NSLog(@"commnArray = %@",commnArray);
	[mainTableView reloadData];
	
}

-(IBAction)featureButtonClicked:(id)sender{
	WhichButtonClicked = 1;
    
    self.strListType = TYPEFEAT;
	
	featureImage.alpha = 1.0;
	categoryImage.alpha = 0.5;
	
	commnArray = [tagDataArray copy];
    //	NSLog(@"commnArray = %@",commnArray);
    
	[mainTableView reloadData];
}


#pragma mark -
#pragma mark <shouldAutorotateToInterfaceOrientation>

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark <didReceiveMemoryWarning> <viewDidUnload> <dealloc>

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	mySearchBar			= nil;
	mainTableView		= nil;
	categoryImage		= nil;
	featureImage		= nil;
	commnArray			= nil;
	stateDictionary		= nil;
	myListObj			= nil;
	//dbHandlerObj = nil;
	
}


- (void)dealloc {
	
	[mySearchBar		release];
	[mainTableView		release];
	[categoryImage		release];
	[featureImage		release];
	[commnArray			release];
	[stateDictionary	release];
	[myListObj			release];
	//[dbHandlerObj		release];
	
    [super dealloc];
}
#pragma mark -
#pragma mark - UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [commnArray count];	
	
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	
	// Retrieve or create a cell
	/*UITableViewCellStyle style =  UITableViewCellStyleDefault;
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
     if (!cell)
     {
     cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     }
	 
	 */
	
	HomePageCell *cell = (HomePageCell *)[tableView dequeueReusableCellWithIdentifier:@"homePageCell"];
	if (!cell) 
	{
		cell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageCell" owner:self options:nil] lastObject];
		cell.backgroundColor=[UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.nameLabel.text = [NSString stringWithFormat:@"%@", [[[commnArray objectAtIndex:indexPath.row] objectForKey:@"name" ] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	cell.catImage.image = [UIImage imageNamed: [[commnArray objectAtIndex:indexPath.row] objectForKey:IMAGEDATAACS]];
    
    
	return (UITableViewCell *)cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSMutableArray *arrayFilter = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[arrayAllData count];i++)
    {
        if([[[arrayAllData objectAtIndex:i]objectForKey:FIELDTYPE] isEqualToString:[[commnArray objectAtIndex:indexPath.row]objectForKey:@"name"]] && [[[arrayAllData objectAtIndex:i]objectForKey:FIELDLISTTYPE] isEqualToString:self.strListType] )
        {
            [arrayFilter addObject:[arrayAllData objectAtIndex:i]];
        }
    }
    
    ListViewController *ListController = [[ListViewController alloc] init];
    ListController.arrayList = [[NSMutableArray alloc] initWithArray:arrayFilter];
    ListController.stringTitle = [[commnArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    ListController.isFromHome = 1;
    [self.navigationController pushViewController:ListController animated:YES];
    [ListController release];
    
    NSLog(@"%@",arrayFilter);
}


#pragma mark -
#pragma mark <UISearchBarDelegate>

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	//search = TRUE;
//	[searchBar resignFirstResponder];
//	[searchBar setShowsCancelButton:FALSE animated:TRUE];
//	
//	char *startstring = "'%";
//	char *end_string = "%'";
//	
//    //	myListObj = [[ListViewController alloc]init];
//    ////	myListObj.queryString = [[NSMutableString alloc]initWithFormat:@"SELECT *,distance(Longitude, Latitude, %f, %f) as DISTANCE From  %@ WHERE VenueNameEng LIKE %s%@%s OR AddressEng LIKE %s%@%s OR Description LIKE %s%@%s OR TagList LIKE %s%@%s",121.89169,30.22722,VENUE_LIST_TABLE,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string];
//    ////	myListObj.queryString = [[NSMutableString alloc]initWithFormat:@"SELECT *,distance(Longitude, Latitude, %f, %f) as DISTANCE From  %@ WHERE VenueNameEng LIKE %s%@%s OR AddressEng LIKE %s%@%s OR Description LIKE %s%@%s OR TagList LIKE %s%@%s  GROUP BY VenueNameEng",121.89169,30.22722,VENUE_LIST_TABLE,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string];
//    //	myListObj.listDataArray =  [[dbHandlerObj fetchListData:[NSString stringWithFormat:@"SELECT VenueID,VenueNameEng,VenueNameChi,Cost,HourEng,HourChi,AddressEng,AddressChi,ZoneEng,ZoneChi,PhoneNumber,Website,Description,Longitude,Latitude,MetroLines,TagList,VenueImage,DealsId,DealsPercentage,MaxDealPer,MetroLine,MetroID,distance(Longitude, Latitude, %f, %f) as DISTANCE From  %@ WHERE VenueNameEng LIKE %s%@%s OR AddressEng LIKE %s%@%s OR Description LIKE %s%@%s OR TagList LIKE %s%@%s ORDER BY VenueNameEng collate NOCASE",121.89169,30.22722,VENUE_LIST_TABLE,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string,startstring,searchBar.text,end_string]] retain];
//    //
//    //	
//    //	myListObj.titleString = [NSString stringWithFormat:@"%@",searchBar.text];
//    //	myListObj.sortingArray	= [[NSMutableArray alloc]initWithObjects:@"By Name",@"By Cost",@"By Distance",@"By Deal",nil];
//    //	[self.navigationController pushViewController:myListObj animated:YES];
	
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	searchBar.text = nil;
	[searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:FALSE animated:TRUE];
	
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	inSearchMode = TRUE;
	[searchBar setShowsCancelButton:TRUE animated:TRUE];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{	
	
	// We're still 'in edit mode', if the user left a keyword in the searchBar
	[searchBar setShowsCancelButton:inSearchMode animated:TRUE];
}



@end
