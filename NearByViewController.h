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

@interface NearByViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,cutomDelegateToolPicker> {
    NSMutableArray *arrayDistanceFilter;
    ViewPickerTool *pickerDis;
    NSMutableArray *arrayNearBy;
    IBOutlet UITableView *tableNearBy;
    IBOutlet UILabel *lableNoNearBy;
}
-(void)tableViewSettingWithRad:(NSInteger)radius;

@end
