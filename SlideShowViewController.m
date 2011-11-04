//
//  SlideShowViewController.m
//  ACSProduct
//
//  Created by preet dhillon on 17/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "SlideShowViewController.h"

@implementation SlideShowViewController
@synthesize urls,downloads,arrayImagesSlide;

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

- (void) didFinishDownload:(NSNumber*)idx {
    //for(int i=0;i<[arrayImages count];i++)
    //{
    NSLog(@"imageget");
    UIActivityIndicatorView *indicator =[[contentDownloading objectAtIndex:[idx intValue]] objectForKey:@"indicator"];
    [indicator stopAnimating];
    
    UIImageView *viewImage = [[contentDownloading objectAtIndex:[idx intValue]] objectForKey:@"image"];
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
#pragma mark - View lifecycle

-(void)back
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: .75];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [[self navigationController] popViewControllerAnimated:NO];
    [UIView commitAnimations];
}
- (void)viewDidLoad
{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    if(TESTING == 1)
        numberOfImages = 1;
    else
        numberOfImages = [arrayImagesSlide count];
    
    [scrollSlideShow setContentSize:CGSizeMake(numberOfImages*320, 416)];
    contentDownloading = [[NSMutableArray alloc] init];
    
    scrollSlideShow.backgroundColor = [UIColor blackColor];
    
    self.urls = [[NSMutableArray alloc]init];
    
    int incX = 10;
    for(int i=0;i<numberOfImages;i++)
    {
        UIImageView *imageSlide = [[UIImageView alloc] initWithFrame:CGRectMake(incX, 10, 300, 376)];
        incX+= 320;
        imageSlide.tag = i;
        [scrollSlideShow addSubview:imageSlide];
        
        
        UIActivityIndicatorView *indicatorWhile = [[UIActivityIndicatorView alloc] init ];
        indicatorWhile.center = imageSlide.center;
        indicatorWhile.tag = i;
        [indicatorWhile startAnimating];
        [imageSlide addSubview:indicatorWhile];
        
        NSMutableDictionary *dictCont = [[NSMutableDictionary alloc] init];
        [dictCont setObject:imageSlide forKey:@"image"];
        [dictCont setObject:indicatorWhile forKey:@"indicator"];
        [contentDownloading addObject:dictCont];
        [dictCont release];
        
        [self.urls addObject:[arrayImagesSlide objectAtIndex:i]];
        
    }
    
    self.downloads = [[MultipleDownload alloc] initWithUrls: urls];
    self.downloads.delegate = self;
    
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
