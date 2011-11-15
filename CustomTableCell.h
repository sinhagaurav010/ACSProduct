//
//  CustomTableCell.h
//  customizeTable
//
//  Created by gaurav on 21/04/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@class EGOImageView;

@interface CustomTableCell : UITableViewCell {
  UIImageView* imageView;
    UILabel *title;
    UILabel *subtitle;
    UILabel *venueNameLabel,*costLabel,*distanceLabel;
}
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *subtitle;
@property(nonatomic,retain)UILabel *venueNameLabel,*costLabel,*distanceLabel,*dealLabel;

-(void)setDealLabelstr:(NSString *)stringTitle;
-(void)setDistanceLabelstr:(NSString *)stringTitle;
-(void)setCostLabelstr:(NSString *)stringTitle;
-(void)settitlestr:(NSString *)stringTitle;

- (void)setPhotoFromUrl:(NSString*)flickrPhoto;
-(void)settitle:(NSString *)stringTitle;
-(void)setsubtitle:(NSString *)stringSubTitle;
@end
