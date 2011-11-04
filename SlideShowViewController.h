//
//  SlideShowViewController.h
//  ACSProduct
//
//  Created by preet dhillon on 17/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "MultipleDownload.h"


@interface SlideShowViewController : UIViewController
{
    IBOutlet UIScrollView *scrollSlideShow;
    NSMutableArray *arrayImagesSlide;
    NSMutableArray *contentDownloading;
    int numberOfImages;
}
@property(nonatomic,retain)    MultipleDownload   *downloads;
@property(nonatomic,retain)    NSMutableArray   *urls;
@property(retain)    NSMutableArray *arrayImagesSlide;

@end
