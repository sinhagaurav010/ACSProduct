//
//  InfoScreenController.h
//  City Guide
//
//  Created by Gaurav Sinha on 27/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Global.h"
#define FONT [UIFont fontWithName:@"Helvetica"  size:14];
#import <QuartzCore/QuartzCore.h>

@interface InfoScreenController : UIViewController <MFMailComposeViewControllerDelegate>{
	
	IBOutlet UIButton *KMSelectButton;//Button used for km on info page.
	IBOutlet UIButton *mileSelectButton;//button used for mile on info page
	IBOutlet UIButton *callButton,*openURLButton,*sendMailButton;
	
	//Alert used on info page
	
	UIAlertView *info_webLinkAlert;
	UIAlertView *info_callAlert;
	UIAlertView *info_mailAlert;
	
	IBOutlet UIScrollView *infoScroll;

}

-(IBAction)KMSelectButtonClicked:(id)sender;
-(IBAction)mileSelectButtonClicked:(id)sender;
-(IBAction)callButtonClicked:(id)sender;
-(IBAction)openURLButtonClicked:(id)sender;
-(IBAction)sendMailButtonClicked:(id)sender;

-(void)infoScreen;

@end
