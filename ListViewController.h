//
//  ListViewController.h
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"
#import "Global.h"
#import "MultipleDownload.h"
#import "DetailsViewController.h"
#import "ModalController.h"
#import "UserLocationFinder.h"
#import "CustomTableCell.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"
#import "XMLReader.h"

@interface ListViewController : UIViewController<ASIHTTPRequestDelegate> {
    IBOutlet UITableView *tableList;
    NSMutableArray *arrayList;
    NSMutableArray *arrayImages;
    BOOL kmsel;
}
@property(nonatomic,retain)    MultipleDownload   *downloads;
@property(nonatomic,retain)    NSMutableArray   *urls;
@property(retain)NSString *stringCat;

@property(retain)NSString *stringTitle;
@property(assign)BOOL isFromHome;
@property(retain)  NSMutableArray *arrayList;
@end
