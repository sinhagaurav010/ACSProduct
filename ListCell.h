//
//  ListCell.h
//  City Guide
//
//  Created by Gaurav Sinha on 17/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"


@interface ListCell : UITableViewCell {
	IBOutlet UIImageView *venueImage,*dealImage;
    IBOutlet EGOImageView *imageMain;
	IBOutlet UILabel *venueNameLabel,*costLabel,*distanceLabel,*line1Label,*line2Label,*line3Label,*dealLabel;

}

@property(nonatomic,retain) UIImageView *venueImage;
@property(nonatomic,retain) UIImageView *dealImage;
@property(nonatomic,retain) UILabel *venueNameLabel;
@property(nonatomic,retain) UILabel *costLabel;
@property(nonatomic,retain) UILabel *distanceLabel;
@property(nonatomic,retain) UILabel *line1Label;
@property(nonatomic,retain) UILabel *line2Label;
@property(nonatomic,retain) UILabel *line3Label;
@property(nonatomic,retain) UILabel *dealLabel;
@property(nonatomic,retain) EGOImageView *imageMain;

@end

