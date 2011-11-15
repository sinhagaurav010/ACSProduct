//
//  ViewPickerTool.h
//  LocoPing
//
//  Created by Rohit Dhawan on 06/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol cutomDelegateToolPicker <NSObject>

-(void)pressDoneForSel:(NSString *)stringSel withindex:(NSInteger)indexRow;

@end

@interface ViewPickerTool : UIView<UIPickerViewDelegate,UIPickerViewDataSource> {
    UIToolbar *toolBarCustom;
    
    id<cutomDelegateToolPicker>client;
    UIBarButtonItem *doneButton;
    
    UIPickerView *pickerSel;
    NSString *stringDate;
    NSInteger intIndex;
    
}
-(void)addTheElement:(NSMutableArray*)array;

@property(retain)    UIToolbar *toolBarCustom;
@property(retain)     UIPickerView *pickerSel;
@property(retain)     id<cutomDelegateToolPicker>client;
@property(retain)      NSString *stringDate;
@property(retain)     NSMutableArray *arrayElement;

@end
