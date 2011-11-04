//
//  HomePageCell.h
//  City Guide
//
//  Created by Gaurav Sinha on 19/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageCell : UITableViewCell {
	
	IBOutlet UIImageView *catImage;
	IBOutlet UILabel *nameLabel;

}

@property(nonatomic,retain) UIImageView *catImage;
@property(nonatomic,retain) UILabel *nameLabel;

@end
