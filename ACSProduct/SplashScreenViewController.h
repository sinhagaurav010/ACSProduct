//
//  SplashScreenViewController.h
//  ACSProduct
//
//  Created by gaurav on 07/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ModalController.h"
#import "Global.h"
#import "XMLReader.h"

@interface SplashScreenViewController : UIViewController<ModalDelegate> {
   IBOutlet UITabBarController *tabBarController;
    ModalController *modal;
}

@end
