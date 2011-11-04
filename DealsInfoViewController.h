//
//  DealsInfoViewController.h
//  ACSProduct
//
//  Created by preet dhillon on 16/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>


@interface DealsInfoViewController : UIViewController
{
    IBOutlet UIView *viewForWebView;
    IBOutlet UIWebView *webViewInfo;
    IBOutlet UILabel *labelCost;
    IBOutlet   UILabel *labelExp;
    IBOutlet    UILabel *labelOff;
}
@property (retain) NSMutableDictionary *dictDealInfo;
@end
