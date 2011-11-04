//
//  TagParser.h
//  City Guide
//
//  Created by Gaurav Sinha on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
//#import "DatabaseHandler.h"


struct Tag{
	
	NSString *tagName;
	NSString *tagImageURL;
};
//@class DatabaseHandler;
@interface TagParser : NSObject {

	struct Tag *tagPtr;
	////////////////////////////////////////////////
	NSXMLParser *xmlParser;
	NSMutableString *tempString;//String that Contains data of the various Tag.
	NSMutableArray *tagListArray;
	
	//DatabaseHandler *dbHandlerObj;

	
}

@end
