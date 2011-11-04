//
//  iCodeBlogAnnotationView.m
//  Find a Park
//
//  Created by Gaurav Sinha on 25/02/10.

//

#import "iCodeBlogAnnotationView.h"

#define kHeight 27//43 //36
#define kWidth  32//22 //30
#define kBorder 2

@implementation iCodeBlogAnnotationView
@synthesize annotation_view_tag;


- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    MyAnnotation* myAnnotation = (MyAnnotation*)annotation;
    //////NSLog(@" myAnnotation.ann_tag------%i", myAnnotation.ann_tag);
    
    annotation_view_tag = myAnnotation.ann_tag;	
    
    //////NSLog(@"annotation_view_tag %i",annotation_view_tag);
    self = [super initWithAnnotation:myAnnotation reuseIdentifier:reuseIdentifier];
    
    self.frame = CGRectMake(0, 0, 20,25);
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView  *view_details  =  [[UIImageView alloc ]init];
    view_details.frame    = CGRectMake(0,0, 14,22);
    view_details.backgroundColor  =  [UIColor clearColor];
    
    if([myAnnotation.stringType isEqualToString:@"Gas"])
        view_details.image	=[UIImage imageNamed:@"pin-red.png"];
    else if([myAnnotation.stringType isEqualToString:@"Oil"])
        view_details.image	=[UIImage imageNamed:@"pin-green.png"];
    else if([myAnnotation.stringType isEqualToString:@"Dry"])
        view_details.image	=[UIImage imageNamed:@"pin-blue.png"];
    else
        view_details.image  = [UIImage imageNamed:@"pin-black.png"]; 
    
    //UILabel  *lbl_details   =
    
    [self addSubview:view_details];
    [view_details release];
    return self;
}


@end
