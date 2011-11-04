//
//  SplashScreenViewController.m
//  ACSProduct
//
//  Created by gaurav on 07/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "SplashScreenViewController.h"


@implementation SplashScreenViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    // [self.navigationController pushViewController:tabBarController
    //                   animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
                                              animated:YES];
    hud.labelText = @"Loading...";
    
    
    modal = [[ModalController alloc] init];
    modal.delegate = self;
    [modal sendTheRequestWithPostString:nil withURLString:URLDATA];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)getdata
{
    NSLog(@"ksdvfv%@",modal.stringRx);
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:modal.
                                         dataXml error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    if([[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"])
    {
        if([[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"] isKindOfClass:[NSArray class]])
            arrayAllData = [[NSMutableArray alloc] initWithArray:[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"]];
        
        else
        {
            arrayAllData = [[NSMutableArray alloc] init];
            [arrayAllData addObject:[[_xmlDictionaryData objectForKey:@"Lists"] objectForKey:@"List"]];
        }
    }
    
    [self.navigationController pushViewController:tabBarController
                                         animated:YES];
    
}

-(void)getError
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    [ModalController showTheAlertWithMsg:@"Error" 
                               withTitle:@"Error in Network"
                            inController:self];
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
