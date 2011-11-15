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

@interface ListViewController : UIViewController {
    IBOutlet UITableView *tableList;
    NSMutableArray *arrayList;
    NSMutableArray *arrayImages;
    BOOL kmsel;
}
@property(nonatomic,retain)    MultipleDownload   *downloads;
@property(nonatomic,retain)    NSMutableArray   *urls;

@property(retain)NSString *stringTitle;
@property(assign)BOOL isFromHome;
@property(retain)  NSMutableArray *arrayList;
@end
