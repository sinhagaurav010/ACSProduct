//
//  ACSProductAppDelegate.h
//  ACSProduct
//
//  Created by gaurav on 06/10/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageController.h"
#import "SplashScreenViewController.h"

@interface ACSProductAppDelegate : NSObject <UIApplicationDelegate> {
    HomePageController *HomeController;
    SplashScreenViewController *SplashScreenController;
    UINavigationController *navigation;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
