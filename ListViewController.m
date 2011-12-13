//
//  ListViewController.m
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "ListViewController.h"


@implementation ListViewController
@synthesize arrayList,stringTitle,isFromHome,downloads,urls;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) didFinishDownload:(NSNumber*)idx {
    //for(int i=0;i<[arrayImages count];i++)
    //{
    NSLog(@"imageget");
    
    UIImageView *viewImage = [arrayImages objectAtIndex:[idx intValue]];
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
    [tableList reloadData];
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
-(void)reloadData:(NSNotificationCenter*)notification
{
    [tableList   reloadData];
}
#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
if(kmsel == 0 && KMselect != 0)
{
    [tableList reloadData];
    kmsel = 1;
}
    else if(kmsel == 1 && KMselect !=1 )
    {
        [tableList reloadData];
        kmsel = 0;
    }
}
- (void)viewDidLoad
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:CHANGEMEASUNIT object:nil];

    [self.navigationController.navigationBar setTintColor:[UIColor blackColor] ];

//    if(self.isFromHome != 1)
//    {
//        self.stringTitle = TITTLELIST;
//        arrayList = [[NSMutableArray alloc] initWithArray:arrayAllData];
//    }
//    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:BASEURL]];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:locationUser.strUserLat forKey:BASELAT];
    [request setPostValue:locationUser.strUserLong forKey:BASELONG];
    [request setPostValue:@"12173" forKey:BASEDIS];
    [request setPostValue:@"" forKey:BASEIND];
    [request setPostValue:@"" forKey:BASECAT];
    [request setDelegate:self];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
    [request startAsynchronous];

    
    [self.navigationItem setTitle:stringTitle];
    
//    self.urls = [[NSMutableArray alloc]init];
//    arrayImages = [[NSMutableArray alloc] init];
//    for(int i=0;i<[arrayList count];i++)
//    {
//        UIImageView *imageViewList = [[UIImageView alloc] initWithFrame:CGRectMake(0,
//                                                                                   1,
//                                                                                   55,
//                                                                                   43)];
//        [arrayImages addObject:imageViewList];
//         [self.urls addObject:[[[[arrayList objectAtIndex:i]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
//    }
//    
    
//    self.downloads = [[MultipleDownload alloc] initWithUrls: urls];
//    self.downloads.delegate = self;
    
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    NSLog(@"I have got data------->>>>>%@",[request responseString]);
    
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:[request responseData] error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    if([[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"])
    {
        if([[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"] isKindOfClass:[NSArray class]])
            arrayList  = [[NSMutableArray alloc] initWithArray:[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"]];
        
        else
        {
            arrayList = [[NSMutableArray alloc] init];
            [arrayList addObject:[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"]];
        }
    }
    
    [tableList reloadData];
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [ModalController showTheAlertWithMsg:@"Error in network" withTitle:@"Failed" inController:self];        
        
}

#pragma mark -
#pragma mark - UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [arrayList count];	
	
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
//	if (!cell) 
//	{
//        NSLog(@"heres");
//        //cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
//		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject] ;
//		cell.backgroundColor=[UIColor whiteColor];
//		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        
//        cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
//        cell.venueNameLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
//        cell.dealLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
//        cell.distanceLabel.text = [NSString stringWithFormat:@"%.3fKm",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]];
////        
//       cell.imageMain.imageURL = [NSURL URLWithString:[[[[arrayList objectAtIndex:indexPath.row]objectForKey:FIELDIMAGES]objectForKey:FIELDIMAGE]objectAtIndex:0]];
//	}
//	
    
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
	if (!cell) 
	{
        NSLog(@"heres");
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCell"];
        cell.accessoryType = 1;
    }
    
    
    
	[cell settitlestr:[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDNAME]];
    [cell setCostLabelstr:[NSString stringWithFormat:@"$%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDCOST]]];
    
    
    [cell setDistanceLabelstr:[NSString stringWithFormat:@"%@",[ModalController  calDistancebetWithLat:[locationUser.strUserLat doubleValue] with:[locationUser.strUserLong doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Lat"]doubleValue] with:[[[arrayList objectAtIndex:indexPath.row ]objectForKey:@"Long"]doubleValue]]]];
    [cell setDealLabelstr:[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDDEAL]];
    [cell setPhotoFromUrl:[NSString stringWithFormat:IMAGEURL,[[arrayList objectAtIndex:indexPath.row]objectForKey:FIELDIMAGE]]];

   
    //cell.venueImage.image = [(UIImageView*)[arrayImages objectAtIndex:indexPath.row] image];
    return (UITableViewCell *)cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DetailsViewController *detailController = [[DetailsViewController    alloc] init];
    detailController.dictInfo = [[NSMutableDictionary alloc] initWithDictionary:[arrayList objectAtIndex:indexPath.row]];
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
//    ListController.arrayList = [[NSMutableArray alloc] initWithArray:arrayFilter];
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
