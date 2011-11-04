//
//  NearByViewController.m
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "NearByViewController.h"


@implementation NearByViewController

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



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    arrayNearBy = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[arrayAllData  count];i++)
    {
    if((int)[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayAllData objectAtIndex:i ]objectForKey:@"Lat"]doubleValue] with:[[[arrayAllData objectAtIndex:i ]objectForKey:@"Long"]doubleValue]]<RADIUS)
    {
        [arrayNearBy addObject:[arrayAllData objectAtIndex:i]];
    }
    }
    NSLog(@"%@",arrayNearBy);
    
    if([arrayNearBy count]==0)
    {
        lableNoNearBy.hidden = NO;
        tableNearBy.hidden = YES;
    }
    else
    {
        lableNoNearBy.hidden = YES;
        tableNearBy.hidden = NO;
        
        tableNearBy.delegate = self;
        tableNearBy.dataSource = self;

    }
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor] ];
    
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -tableview code-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [arrayNearBy count];	
	
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
	
	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
	if (!cell) 
	{
        NSLog(@"heres");
        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject] ;
		cell.backgroundColor=[UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
        cell.venueNameLabel.text = [[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
        cell.dealLabel.text = [[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
        cell.distanceLabel.text = [NSString stringWithFormat:@"%.3fKm",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]];
        //        
        cell.imageMain.imageURL = [NSURL URLWithString:[[[[arrayNearBy objectAtIndex:indexPath.row]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
	}
	
    
    //cell.venueImage.image = [(UIImageView*)[arrayImages objectAtIndex:indexPath.row] image];
    return (UITableViewCell *)cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DetailsViewController *detailController = [[DetailsViewController    alloc] init];
    detailController.dictInfo = [[NSMutableDictionary alloc] initWithDictionary:[arrayNearBy objectAtIndex:indexPath.row]];
    detailController.isFromFav = 0;
    [self.navigationController pushViewController:detailController
                                         animated:YES];
    [detailController release];
    
    //    NSMutableArray *arrayFilter = [[NSMutableArray alloc] init];
    //    
    //    for(int i=0;i<[arrayAllData count];i++)
    //    {
    //        if([[[arrayAllData objectAtIndex:i]objectForKey:FIELDTYPE] isEqualToString:[[commnArray objectAtIndex:indexPath.row]objectForKey:@"name"]] && [[[arrayAllData objectAtIndex:i]objectForKey:FIELDLISTTYPE] isEqualToString:self.strListType] )
    //        {
    //            [arrayFilter addObject:[arrayAllData objectAtIndex:i]];
    //        }
    //    }
    //    
    //    ListViewController *ListController = [[ListViewController alloc] init];
    //    ListController.arrayNearBy = [[NSMutableArray alloc] initWithArray:arrayFilter];
    //    [self.navigationController pushViewController:ListController animated:YES];
    //    [ListController release];
    //    
    //    NSLog(@"%@",arrayFilter);
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
