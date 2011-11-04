//
//  DetailsViewController.h
//  ACSProduct
//
//  Created by preet dhillon on 16/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "DealsInfoViewController.h"
#import "ModalController.h"
#import "SlideShowViewController.h"
#import "MapViewController.h"
#import <MessageUI/MessageUI.h>


@interface DetailsViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    IBOutlet UIView *viewForWebView;
    IBOutlet UIWebView *webViewInfo;
    NSMutableArray *arrayTableInfo;
    IBOutlet UITableView *tableInfo;
    NSMutableArray *arrayInfo;
    IBOutlet UIButton *buttonFav;
    IBOutlet UIButton *buttonEail;
    IBOutlet UIButton *buttonFaceBook;
    IBOutlet UIButton *buttonTwitter;
    
}


-(void)clickOn:(NSString *)stringEmailId;

@property(assign)BOOL isFromFav;
-(IBAction)touchToAddFav:(id)sender;
-(IBAction)ShareFace:(id)sender;
-(IBAction)ShareTwitter:(id)sender;
-(IBAction)EmailToFriend:(id)sender;

-(IBAction)touchForDeal:(id)sender;
-(IBAction)touchForMap:(id)sender;
@property(retain) NSString *stringTitle;
@property(retain) NSMutableDictionary *dictInfo;
@end
