//
//  NearByViewController.h
//  ACSProduct
//
//  Created by gaurav on 09/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "ModalController.h"
#import "UserLocationFinder.h"
#import "ListCell.h"
#import "DetailsViewController.h"
#import "ViewPickerTool.h"
#import "MultipleDownload.h"
#import "CustomTableCell.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface NearByViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,cutomDelegateToolPicker> {
    NSMutableArray *arrayDistanceFilter;
    ViewPickerTool *pickerDis;
    IBOutlet UITableView *tableNearBy;
    BOOL kmsel;
    IBOutlet UILabel *lableNoNearBy;
}
-(void)tableViewSettingWithRad:(NSInteger)radius;
@property(nonatomic,retain)    MultipleDownload   *downloads;
@property(nonatomic,retain)    NSMutableArray   *urls;
@property(retain)    NSMutableArray *arrayImageView;

@end
