//
//  HomePageController.h
//  City Guide
//
//  Created by Gaurav Sinha on 27/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
//#import "DatabaseHandler.h"
#import "ListViewController.h"
@class ListViewController;
@interface HomePageController : UIViewController {
	
	IBOutlet UISearchBar *mySearchBar;		// Add seach bar
	IBOutlet UITableView *mainTableView;	// Add Main Table to display Category and Feature List
	
	IBOutlet UIImageView *categoryImage;
	IBOutlet UIImageView *featureImage;
	
	BOOL inSearchMode;
	
//	NSMutableArray *catDataArray;
//	NSMutableArray *tagDataArray;
	
	NSMutableArray *commnArray;
	
	NSMutableDictionary *stateDictionary;
	
	NSInteger WhichButtonClicked;
	ListViewController *myListObj;
	
	//DatabaseHandler *dbHandlerObj;

}
-(void)addobjINdictwithStringName:(NSString*)strName withImageName:(NSString*)strImage inArr:(BOOL)isInCat;
@property(retain)NSString *strListType;
@property(nonatomic,retain)UISearchBar *mySearchBar;
@property(nonatomic,retain)ListViewController *myListObj;


-(IBAction)categoryButtonClicked:(id)sender;
-(IBAction)featureButtonClicked:(id)sender;
@end
