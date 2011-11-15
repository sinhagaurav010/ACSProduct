//
//  CustomTableCell.m
//  customizeTable
//
//  Created by gaurav on 21/04/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "CustomTableCell.h"
#import "EGOImageView.h"


@implementation CustomTableCell
@synthesize title,subtitle,venueNameLabel,costLabel,distanceLabel,dealLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            
            imageView = [[UIImageView     alloc] init];
            //imageView.frame = CGRectMake(4, 4, 62, 62);
            imageView.frame = CGRectMake(4.0f, 4.0f, 36.0f, 36.0f);
            [self addSubview:imageView];

            
//            self.title = [[UILabel alloc] initWithFrame:CGRectMake(72, 4, 200, 30)];
//            self.title.textColor = [UIColor blackColor];
//            self.title.font = [UIFont boldSystemFontOfSize:18];
//            self.title.font = [UIFont fontWithName:@"futura" size:18];
//            self.title.backgroundColor = [UIColor clearColor];
//            [self addSubview:title];
//            
//            self.subtitle = [[UILabel alloc] initWithFrame:CGRectMake(72, 32, 200, 30)];
//            self.subtitle.textColor = [UIColor blackColor];
//            self.subtitle.font = [UIFont fontWithName:@"futura" size:12];
//            self.subtitle.backgroundColor = [UIColor clearColor];
//            [self addSubview:subtitle];

            self.venueNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 2, 184, 21)];
            self.venueNameLabel.font = [UIFont boldSystemFontOfSize:14];
            self.venueNameLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:venueNameLabel];
            
            self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 23,64,21)];
            self.distanceLabel.font = [UIFont systemFontOfSize:12];
            self.distanceLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:distanceLabel];
            
            self.costLabel = [[UILabel alloc] initWithFrame:CGRectMake(63, 23, 64, 21)];
            self.costLabel.font = [UIFont systemFontOfSize:12];
            self.costLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:costLabel];
            
            self.dealLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 23, 48, 20)];
            self.dealLabel.font = [UIFont systemFontOfSize:12];
            self.dealLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:dealLabel];
            
        }
        // Initialization code
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    if(selected == 1)
//    {
//        self.subtitle.textColor = [UIColor blackColor];
//    self.title.textColor = [UIColor blackColor];
//    }
//    else
//    {
//        self.subtitle.textColor = [UIColor whiteColor];
//        self.title.textColor = [UIColor whiteColor];
//    }
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)settitle:(NSString *)stringTitle
{
    self.title.text = stringTitle;
}

-(void)setsubtitle:(NSString *)stringSubTitle
{
    self.subtitle.text = stringSubTitle;
}

- (void)setPhotoFromUrl:(NSString*)flickrPhoto
{
    [self.imageView setImageWithURL:[NSURL URLWithString:flickrPhoto]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

-(void)setDealLabelstr:(NSString *)stringTitle
{
    self.dealLabel.text = stringTitle;
}

-(void)setDistanceLabelstr:(NSString *)stringTitle
{
    self.distanceLabel.text = stringTitle;
}
-(void)setCostLabelstr:(NSString *)stringTitle
{
    self.costLabel.text = stringTitle;
}
-(void)settitlestr:(NSString *)stringTitle
{
    self.venueNameLabel.text = stringTitle;
}


- (void)dealloc
{
    [title release];
    [subtitle release];
    [imageView release];
    [super dealloc];
}

@end
