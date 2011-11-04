//
//  HomePageCell.m
//  City Guide
//
//  Created by Gaurav Sinha on 19/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomePageCell.h"


@implementation HomePageCell

@synthesize catImage;
@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	
	[catImage	release];
	[nameLabel	release];
	
    [super dealloc];
}


@end
