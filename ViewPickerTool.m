//
//  ViewPickerTool.m
//  LocoPing
//
//  Created by Rohit Dhawan on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewPickerTool.h"


@implementation ViewPickerTool
@synthesize toolBarCustom,pickerSel,client,stringDate,arrayElement;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.toolBarCustom = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self addSubview:toolBarCustom];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self action:@selector(DoneButtonClicked)];
        // Initialization code
        toolBarCustom.barStyle = UIBarStyleBlack;
        
        [toolBarCustom setItems:[NSArray arrayWithObjects:doneButton, nil]];
        
        
        pickerSel = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 150)];
        
        pickerSel.showsSelectionIndicator = YES;
        [self addSubview:pickerSel];
        
        // Initialization code
    }
    return self;
}

-(void)addTheElement:(NSMutableArray*)array
{
    self.arrayElement = [[NSMutableArray alloc] init];
    self.arrayElement = array;
    if([arrayElement count]>0)
        self.stringDate = [arrayElement objectAtIndex:0];
    self.pickerSel.delegate = self;
    self.pickerSel.dataSource = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.arrayElement count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrayElement objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.stringDate = [self.arrayElement objectAtIndex:row];
    intIndex = row;
    //[self.client pickerOptionSelectedWithIndex:row];
}

-(void)DoneButtonClicked
{
    [self.client pressDoneForSel:self.stringDate withindex:intIndex];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    [super dealloc];
}

@end
