//
//  DetailsViewController.m
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
 Images =     {
 Image =         (
 "http://londoncontemporaryart.files.wordpress.com/2009/02/london_art_fair_500_rgb.jpg",
 ImageLink2,
 ImageLink3
 );
 };
 ListType = Cat;
 Loc = London;
 Name = "288 The Melting Point";
 Phone = 1234532;
 Type = "Arts and Entertainment";
 URL = "http://www.acs.com";
 }
 
 */
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

/*
 1) I can see the get direction feature (excellent) in the maps, but as yet the location services are still fixed on London rather than picking up my actual location.
 Done
 
 2) I can see that the URL, phone and e-mail features are now all working, however:. The app should bring up the warning prompt about leaving the app to open the website from the URL, the app should bring up the warning prompt to ask if the user wants to dial the number as it currentlly does when selecting from the information page.
 Done
 
 
 3) When selecting an item at present, I see the following issues: a) There is an > to the right of the Name, suggesting an option but there isnt one. There is an > to the right of the address, which I would have expected to take me to the address of the entry on the map? This doesn’t work yet.
 Done
 
 4) There is a favourites option on the list and also on the bottom navigation. The list entry does not work, and I would suggest can be removed.
 Did not get clarification from your side.
 
 5) The title on the favourites screen is 'Root View Controller'. Is there any limit to the number of favourites that can be added? Can we have a popup warning prompt as per the Phone and URL when adding an entry to the favourites?
 Done
 
 6) The title on the nearby screen is 'Root View Controller'. Is there any limit to the number of favourites that can be added? Can we have a popup warning prompt as per the Phone and URL when adding an entry to the favourites?
 Done
 
 7) There appear to be some stability issues. When I have been using the app and browsing around for a few minutes, it seems to go very slow and doesn’t show backgrounds on certain graphics like the main listview etc.
 Still there(with testing it will resolve).
 
 
 8) For future updates, can you dropbox the source code. The device I am using for testing is synced to a PC not my MAC, so I keep having to resync to test an ipa. I prefer to be able to build the Xcode and simulate that way. It also allows us to point to another URL for the data, which we have done successfully.
 Code is in git hub.
 
 */
#import "DetailsViewController.h"

@implementation DetailsViewController
@synthesize dictInfo,isFromFav,stringTitle;
@synthesize facebook = _facebook;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
-(IBAction)touchForDeal:(id)sender
{
    DealsInfoViewController *dealsController = [[DealsInfoViewController alloc] init];
    dealsController.dictDealInfo = [[NSMutableDictionary alloc] initWithDictionary:dictInfo];
    [self.navigationController pushViewController:dealsController animated:YES];
    [dealsController release];
}

-(void)imageButtonClicked:(id)sender
{
    SlideShowViewController *myInfoScreenController = [[SlideShowViewController alloc]init];
    myInfoScreenController.arrayImagesSlide = [[dictInfo objectForKey:FIELDIMAGES] objectForKey:FIELDIMAGE];
	myInfoScreenController.hidesBottomBarWhenPushed = YES;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[[self navigationController] pushViewController:myInfoScreenController animated:NO];
	[UIView commitAnimations];
    
}
-(IBAction)touchForMap:(id)sender
{
    
    MapViewController *mapController = [[MapViewController alloc] init];
    mapController.isFromDetail = 1;
    mapController.arrayMapLocs = [[NSMutableArray alloc] init];
    [mapController.arrayMapLocs addObject:dictInfo];
    [self.navigationController pushViewController:mapController animated:YES];
    [mapController release];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    ///FOR FACEBookINtegartion
    
    ACSProductAppDelegate  * appDelegate = (ACSProductAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Grab the facebook object from the app delegate.
    _facebook = appDelegate.facebook;
    _permissions =  [[NSArray arrayWithObjects:
                      @"read_stream", @"publish_stream", @"offline_access",@"email",@"user_birthday",@"user_photos",nil] retain];
    // _facebook = [[Facebook alloc] initWithAppId:AppIDAPI];
    
    //_facebook.sessionDelegate = self;
    
    _fbButton.isLoggedIn = NO;
    //_fbButton.
    [_fbButton updateImage];
    
    self.navigationItem.title = [dictInfo objectForKey:FIELDNAME];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = saveButton;
    [saveButton release];
    
    if(isFromFav == 1)
        buttonFav.hidden = YES;
    
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithTitle:@"Images"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(imageButtonClicked:)];
    self.navigationItem.rightBarButtonItem = imageButton;
    [imageButton release];
	
    arrayInfo = [[NSMutableArray alloc] initWithArray:[[NSArray alloc]initWithObjects:@"Name",@"Address",@"Email",@"Phone",@"Url", nil]];
    tableInfo.backgroundView = nil;
    tableInfo.backgroundColor = [UIColor clearColor];
    tableInfo.hidden = NO;
    
    [viewForWebView.layer setCornerRadius:35.0f];
    [viewForWebView.layer setMasksToBounds:YES];
    
    tableInfo.delegate = self;
    tableInfo.dataSource  = self;
    [tableInfo reloadData];
    
    //    webViewInfo.backgroundColor = [UIColor colorWithRed:.96
    //                                                  green:.57
    //                                                   blue:.12
    //                                                  alpha:1.0];
    
    [webViewInfo loadHTMLString:[dictInfo objectForKey:FIELDDESC] baseURL:nil];
    NSLog(@"-----%@",dictInfo);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mafrk -add to Fav-
-(IBAction)touchToAddFav:(id)sender
{
    isSaveToFav = 1;
    NSMutableArray *arrayFav = [[NSMutableArray alloc] initWithArray:(NSMutableArray*)[ModalController getContforKey:SAVEFAV]];
    [arrayFav addObject:dictInfo];
    [ModalController saveTheContent:arrayFav withKey:SAVEFAV];
    [arrayFav release];
}

#pragma mark -mail composer-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}


-(void)clickOn:(NSString *)stringEmailId withMessage:(NSString *)strMsg
{
    //NSLog(@"clickon");
	NSArray *arrayRec = [NSArray arrayWithObjects:stringEmailId,nil];
    //NSLog(@"%d",[MFMailComposeViewController canSendMail]);
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		//[mcvc setSubject:EMAILSUB];
		[mcvc setToRecipients:arrayRec];
        
        
        //		NSString *messageBdy = [NSString stringWithFormat:@"Name %@<br>Phone %@ <br>Address %@<br>%@<br>City %@ <br>%@<br> %@<br>special features%@",textname.text,textphone.text,textAddress.text,buttonTime.titleLabel.text,textCity.text,buttonBed.titleLabel.text,buttonBath.titleLabel.text,textfea.text];
        
        [mcvc setMessageBody:strMsg    isHTML:NO];
		
        //[mcvc addAttachmentData:UIImageJPEGRepresentation(imageToEmail, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
		[self presentModalViewController:mcvc animated:YES];
	}	
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                           message:@"Please Configure Email" 
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles: nil];
        [alerView show];
        [alerView release];
    }
}

#pragma mark -
#pragma mark - UITableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%d",[arrayInfo count]);
	// The number of sections is based on the number of items in the data property list.
	return [arrayInfo count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayInfo objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;	
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"here");
    switch (indexPath.section) {
        case 1:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                            message:MAP_VISIT 
                                                           delegate:self 
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"NO",@"YES", nil];
            alert.tag = 1;
            [alert show];
            [alert release];
            break;
        }
        case 3:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                            message:DIAL_A_NUMBER 
                                                           delegate:self 
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"NO",@"YES", nil];
            alert.tag = 3;
            [alert show];
            [alert release];
            break;
        }
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
                                                            message:WEBLINK_VISIT 
                                                           delegate:self 
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"NO",@"YES", nil];
            alert.tag = 4;
            [alert show];
            [alert release];
        }
            break;
        case 2:
        {
            [self clickOn:[dictInfo objectForKey:FIELDEMAIL] withMessage:nil];
        }
            break;
            
        default:
            break;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	NSLog(@"cell");
    
	// Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell ==  nil)
    {
        NSLog(@"chi");

        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
        
        if(indexPath.section != 0)
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = [dictInfo objectForKey:FIELDNAME];
                break;
            case 1:
                cell.textLabel.text = [dictInfo objectForKey:FIELDADD];
                break;
            case 2:
                cell.textLabel.text = [dictInfo objectForKey:FIELDEMAIL];
                break;
            case 3:
                cell.textLabel.text = [dictInfo objectForKey:FIELDPHONE];
                break;
            case 4:
                cell.textLabel.text = [dictInfo objectForKey:FIELDURL];
                break;
            default:
                break;
        }

    }
    
        //	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    //	if (!cell) 
    //	{
    //		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject];
    //		cell.backgroundColor=[UIColor whiteColor];
    //		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //	}
    //	
    //    
    //    cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
    //    cell.venueNameLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
    //    cell.dealLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
    //    cell.distanceLabel.text = @" ";
    //    
    //    cell.venueImage.image = [(UIImageView*)[arrayImages objectAtIndex:indexPath.row] image];
    return (UITableViewCell *)cell;
	
}

#pragma mark -Delegate AlertView-
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 1)
    {
        switch (alertView.tag) {
            case 1:
            {
                NSString *stringURL = [NSString stringWithFormat:LINKMAPADD,[[dictInfo objectForKey:FIELDADD]stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
                NSLog(@"%@",stringURL);
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];
                break;
            }  
            case 3:
            {
                NSString *stringURL = [NSString stringWithFormat:@"tel:%@",[dictInfo objectForKey:FIELDPHONE]];
                NSLog(@"%@",stringURL);
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];
                break;
            }    
            case 4:
            {
                NSString *stringURL = [dictInfo objectForKey:FIELDURL];
                NSLog(@"%@",stringURL);
                NSURL *url = [NSURL URLWithString:stringURL];
                [[UIApplication sharedApplication] openURL:url];            
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark -code for Facebook-

- (void)login {
    NSLog(@"Login Press");
    [_facebook authorize:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    [_facebook logout:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)fbButtonClick:(id)sender {
    if (_fbButton.isLoggedIn) {
        [self logout];
    } else {
        [self login];
    }
}

/**
 * Make a Graph API Call to get information about the current logged in user.
 */
//- (IBAction)getUserInfo:(id)sender {
//    [_facebook requestWithGraphPath:@"me" andDelegate:self];
//}


/**
 * Make a REST API call to get a user's name using FQL.
 */
- (IBAction)getPublicInfo:(id)sender {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"SELECT uid,name FROM user WHERE uid=4", @"query",
                                    nil];
    [_facebook requestWithMethodName:@"fql.query"
                           andParams:params
                       andHttpMethod:@"POST"
                         andDelegate:self];
}

/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (IBAction)publishStream:(id)sender {
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
    
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"a long run", @"name",
                                
                                @"The Facebook Running app", @"caption",
                                @"it is fun", @"description",
                                @"http://itsti.me/", @"href", nil];
    NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    
    [_facebook dialog:@"feed"
            andParams:params
          andDelegate:self];
    
}
- (void)publishFeed{
	
    //	categoryListArray = [[CategoryDataDict objectForKey:[keyArray objectAtIndex:whichSectionSelected]] copy];
    //	
    //	NSLog(@"[CategoryDataDict allValues] = %@",categoryListArray);
    //	[[categoryListArray objectAtIndex:whichRowSelected]getValue:&catDataStruct];
	
	//titleLabel.text = [NSString stringWithFormat:@"%@",p.newsTitle];
	//descriptionLabel.text = [NSString stringWithFormat:@"%@",p.newsDescription];
	//dateAndTimeLabel.text = [NSString stringWithFormat:@"%@",p.newsPubDate];
    //	NSString *tid=[NSString stringWithFormat:@"%l", _session.uid];
    //	NSString *body = [dictInfo objectForKey:FIELDDESC];
    //    //	if (isShareMail) {
    //    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
    //    //	}else {
    //    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[[dealsDataArray objectAtIndex:dealsMailShowIndex] objectForKey:@"dealDetails"]]];
    //    //	}
    //	
    //	
    //    //  NSString *body    = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
    //	
    //	//  NSString *body    = @"This News is posted through News Paper App";
    //	
    //	//  float latitude = appDelegate.currentLocation.coordinate.latitude;
    //	//  float longitude = appDelegate.currentLocation.coordinate.longitude;
    //	
    //	// NSString *attach = [NSString stringWithFormat:@"{\"name\":\"Here I Am\",\"href\":\"http://maps.google.com/?q=%f,%f\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"description\":\"Shared using GeoMashable on the iPad\",\"media\":[{\"type\":\"image\",\"src\":\"http://www.geomashable.com/images/icon.png\",\"href\":\"http://www.geomashable.com\"}],\"properties\":{\"Download\":{\"text\":\"Click here to Download now\",\"href\":\"http://www.geomashable.com\"}}}",latitude,longitude,latitude,longitude];
    //	
    //	// NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.geomashable.com\"}]";
    //	// NSArray *obj = [NSArray arrayWithObjects:body,attach,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
    //	// NSArray *keys = [NSArray arrayWithObjects:@"message",@"attachment",@"action_links",@"target_id",nil];
    //	NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.google.com\"}]";
    //	
    //	
    //    NSArray *obj = [NSArray arrayWithObjects:body,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
    //    NSArray *keys = [NSArray arrayWithObjects:@"message",@"action_links",@"target_id",nil];
    //    NSDictionary *params = [NSDictionary dictionaryWithObjects:obj forKeys:keys];
    //    [[FBRequest requestWithDelegate:self] call:@"facebook.stream.publish" params:params];
}

/**
 * Upload a photo.
 */


//TO start the activity indicator

//To stop the activity indicator



// Override to allow orientations other than the default portrait orientation.


/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    
    NSLog(@"fbLogin");
    _fbButton.isLoggedIn = YES;
    [_fbButton updateImage];
    // FBRequest *request = [[FBRequest alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    //
    //    
    //    
    //    request = [_facebook requestWithGraphPath:@"me" andDelegate:self];
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    
    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"link"];
    //[variables setObject:@"http://farm6.static.flickr.com/5015/5570946750_a486e741.jpg" forKey:@"picture"];
    [variables setObject:@"You scored 99999" forKey:@"name"];
    [variables setObject:@" " forKey:@"caption"];
    [variables setObject:[NSString stringWithFormat:@"%@",[dictInfo objectForKey:FIELDDESC]] forKey:@"message"];
    
    [_facebook requestWithMethodName:@"stream.publish" andParams:variables andHttpMethod:@"POST" andDelegate:self];
}
/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    _fbButton.isLoggedIn         = NO;
    [_fbButton updateImage];
}


////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
    
}
- (void)request:(FBRequest *)request didLoad:(id)result {
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    [ModalController showTheAlertWithMsg:@"Posted in FaceBook" 
                               withTitle:@"Success"
                            inController:self];
    
    // [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];    
    
    //    if ([result isKindOfClass:[NSDictionary class]]) {
    //        dictResponse = [[NSMutableDictionary alloc] init];
    //        
    //        if([result objectForKey:@"birthday"])
    //            [dictResponse setObject:[result objectForKey:@"birthday"] forKey:@"birthday"];
    //        if([result objectForKey:@"email"])
    //            [dictResponse setObject:[result objectForKey:@"email"] forKey:@"email"];
    //        if([result objectForKey:@"first_name"])
    //            [dictResponse setObject:[result objectForKey:@"first_name"] forKey:@"first_name"];
    //        if([result objectForKey:@"last_name"])
    //            [dictResponse setObject:[result objectForKey:@"last_name"] forKey:@"last_name"];
    //        if([result objectForKey:@"gender"])
    //            [dictResponse setObject:[result objectForKey:@"gender"] forKey:@"gender"];
    //        if([result objectForKey:@"work"])
    //            if([[[result objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"])
    //                if([[[[result objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"] objectForKey:@"name"])
    //                    [dictResponse setObject:[[[[result objectForKey:@"work"] objectAtIndex:0]  
    //                                              objectForKey:@"employer"] 
    //                                             objectForKey:@"name"] forKey:@"employee"];
    //        
    //        if ([result objectForKey:@"id"]) {
    //            [dictResponse setObject:[result objectForKey:@"id"] forKey:@"fbId"];
    //        }
    //        
    //        modal = [[ModalController alloc] init];
    //        
    //        NSString *stringAuthLogin = [NSString stringWithFormat:@"email=%@&facebook_id=%@",[dictResponse 
    //                                                                                           objectForKey:@"email"],[dictResponse objectForKey:@"fbId"]];
    //        
    //        ////NSLog(@"string%@",stringAuthLogin);
    //        
    //        modal.delegate = self;
    //        
    //        //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //        //        hud.labelText = @"Loading...";
    //        
    //        [modal sendTheRequestWithPostString:stringAuthLogin withURLString:URLFACEBOOKLOGIN];
    /////////////////////////
    //        RegistrationViewController *RegistrationController = [[RegistrationViewController alloc] init];
    //        RegistrationController.dictFacebook = [NSMutableDictionary dictionaryWithDictionary:dictResponse];
    //        [self.navigationController pushViewController:RegistrationController animated:YES];
    
    //[dictResponse release];
    
    //}
    //	[self dismissModalViewControllerAnimated:TRUE];
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.navigationController.view
                         animated:YES];
    
    [ModalController    showTheAlertWithMsg:@"Failed To Post" withTitle:@"Sorry" inController:self];
}


////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
}





#define mark -Integration of SocailNetworking-
-(IBAction)ShareFace:(id)sender
{
}
-(IBAction)ShareTwitter:(id)sender
{
    [ModalController showTheAlertWithMsg:@"Comming Soon" 
                               withTitle:@"Info"
                            inController:self];
}
-(IBAction)EmailToFriend:(id)sender
{
    [self clickOn:nil withMessage:[dictInfo objectForKey:FIELDDESC]]; 
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
