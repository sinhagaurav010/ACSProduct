//
//  ListCell.m
//  City Guide
//
//  Created by Gaurav Sinha on 17/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListCell.h"


@implementation ListCell

@synthesize venueImage,dealImage,imageMain,venueNameLabel,costLabel,distanceLabel,line1Label,line2Label,line3Label,dealLabel;


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
	
	[venueImage		release];
	[dealImage		release];
	[venueNameLabel release];
	[costLabel		release];
	[distanceLabel	release];
	[line1Label		release];
	[line2Label		release];
	[line3Label		release];
	[dealLabel		release];
	
    [super dealloc];
}


@end
