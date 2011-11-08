//
//  ACSProductAppDelegate.h
//  ACSProduct
//
//  Created by gaurav on 06/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomePageController.h"
#import "SplashScreenViewController.h"
#import "DetailsViewController.h"
#import "Facebook.h"
#import "Global.h"

@interface ACSProductAppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate> 
{
    
//    HomePageController *HomeController;
//    DetailsViewController *lginController;

    SplashScreenViewController *SplashScreenController;
    UINavigationController *navigation;
    Facebook * facebook;
}
@property (retain, nonatomic) Facebook * facebook;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
