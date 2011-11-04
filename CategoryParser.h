//
//  CategoryParser.h
//  City Guide
//
//  Created by Gaurav Sinha on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
//#import "DatabaseHandler.h"

#define CATEGORY_TABLE_NAME @"CategoryList"

// Structure that contains the category data
struct Category{
	
	NSString *categoryName;
	NSString *categoryImageURL;
};
//@class DatabaseHandler;


@interface CategoryParser : NSObject {
	
	struct Category *categoryPtr;
	////////////////////////////////////////////////
	NSXMLParser *xmlParser;
	NSMutableString *tempString;//String that Contains data of the various Tag.
	NSMutableArray *categoryListArray;
	
	//DatabaseHandler *dbHandlerObj;

}

@end
