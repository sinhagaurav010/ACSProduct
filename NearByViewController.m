//
//  NearByViewController.m
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "NearByViewController.h"


@implementation NearByViewController
@synthesize urls,downloads,arrayImageView;


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

- (void) didFinishDownload:(NSNumber*)idx {
    //for(int i=0;i<[arrayImages count];i++)
    //{
    NSLog(@"imageget");
       
    UIImageView *viewImage = [arrayImageView objectAtIndex:[idx intValue]];
    viewImage.image = [UIImage imageWithData:[downloads dataAtIndex:[idx intValue]]];
    
    //}
    //    if([idx intValue]==0)
    //    {
    //    
    //        imageV1.image = [UIImage imageWithData:[downloads dataAtIndex:[idx intValue]]];
    //
    //    }
    //    if([idx intValue]==1)
    //    {
    //        
    //        imageV2.image = [UIImage imageWithData:[downloads dataAtIndex:[idx intValue]]];
    //        
    //    }
    //[arrayAlbums addObject:[[[downloads dataAsStringAtIndex: [idx intValue]] JSONValue]copy]];
	//NSLog(@"%d download: %@", [idx intValue], [downloads dataAsStringAtIndex: [idx intValue]]);
    
}

- (void) didFinishAllDownload {
    // [tableList reloadData];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -Delegate viewToolPicker-
-(void)pressDoneForSel:(NSString *)stringSel withindex:(NSInteger)indexRow
{
    pickerDis.hidden = YES;
    
    [self tableViewSettingWithRad:[[arrayDistanceFilter objectAtIndex:indexRow ]intValue]];

}


-(void)filterButtonClicked
{
    pickerDis.hidden = NO;
}
-(void)reloadData:(NSNotificationCenter*)notification
{
    [tableNearBy   reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(kmsel == 0 && KMselect != 0)
    {
        [tableNearBy    reloadData];
        kmsel = 1;
    }
    else if(kmsel == 1 && KMselect !=1 )
    {
        [tableNearBy reloadData];
        kmsel = 0;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:CHANGEMEASUNIT object:nil];

    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(filterButtonClicked)];
    self.navigationItem.rightBarButtonItem = filterButton;
    [filterButton release];

    
    NSArray *arrayDistance = [NSArray arrayWithObjects:@"0-50",@"0-100",@"0-150",@"0-200",@"0-250", nil];
    arrayDistanceFilter = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"6805",@"6600",@"6719",@"6720",@"250", nil]];
    
    NSMutableArray *arrayDis = [[NSMutableArray alloc] initWithArray:arrayDistance];
    
    pickerDis = [[ViewPickerTool alloc] initWithFrame:CGRectMake(0, 0, 320, 194)];
    [self.view addSubview:pickerDis];
    [pickerDis setClient:self];
    pickerDis.hidden = YES;
    [pickerDis addTheElement:arrayDis];
    
    [self.navigationItem setTitle:TITLENEARBY];
    
    [self tableViewSettingWithRad:100];
   
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor] ];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)tableViewSettingWithRad:(NSInteger)radius
{
    
    arrayNearBy = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[arrayAllData  count];i++)
    {
        if((int)[ModalController calDistancebetWithLatForDis:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayAllData objectAtIndex:i ]objectForKey:@"Lat"]doubleValue] with:[[[arrayAllData objectAtIndex:i ]objectForKey:@"Long"]doubleValue]]<radius)
        {
            [arrayNearBy addObject:[arrayAllData objectAtIndex:i]];
        }
        
         
    }
    NSLog(@"---------%@",arrayNearBy);
    
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
        
     //   arrayImageView = [[NSMutableArray alloc] init];

    //    self.urls = [[NSMutableArray alloc]init];
        
       // int incX = 10;
//        for(int i=0;i<[arrayNearBy count];i++)
//        {
//            UIImageView *imageSlide = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 55, 43)];
//            incX+= 320;
//            imageSlide.tag = i;
//            
//            [arrayImageView addObject:imageSlide];
//            [self.urls addObject:[[[[arrayNearBy objectAtIndex:i]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
//        }
//        
        
//        self.downloads = [[MultipleDownload alloc] initWithUrls: urls];
//        self.downloads.delegate = self;
//
        [tableNearBy    reloadData];
    }
    
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
	
//	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
	CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];

	if (!cell) 
	{
        NSLog(@"heres");
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
//		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject] ;
//		cell.backgroundColor=[UIColor whiteColor];
//		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
//        cell.venueNameLabel.text = [[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
//        cell.dealLabel.text = [[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
//        cell.distanceLabel.text = [NSString stringWithFormat:@"%.3fKm",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]];
//        //        
//        //cell.imageMain.imageURL = [NSURL URLWithString:[[[[arrayNearBy objectAtIndex:indexPath.row]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
//        cell.venueImage.image = [(UIImageView *)[arrayImageView objectAtIndex:indexPath.row] image];
	}
    cell.accessoryType = 1;
    
	[cell settitlestr:[[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDNAME]];
    [cell setCostLabelstr:[NSString stringWithFormat:@"$%@",[[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDCOST]]];
    [cell setDistanceLabelstr:[NSString stringWithFormat:@"%@",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayNearBy objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]]];
    [cell setDealLabelstr:[[arrayNearBy objectAtIndex:indexPath.row] objectForKey:FIELDDEAL]];
    [cell setPhotoFromUrl:[[[[arrayNearBy objectAtIndex:indexPath.row]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
    
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
