//
//  CategoryParser.m
//  City Guide
//
//  Created by Gaurav Sinha on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryParser.h"


@implementation CategoryParser

//Start parser
- (void)startCategoryParser
{
	
	// Used to retrive the data from data from XML file.
	//NSString* filePath = [[NSBundle mainBundle] pathForResource:@"NewsApp" ofType:@"xml"];
	//NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	
	//NSData* mydata = [fileContents dataUsingEncoding: NSUTF16StringEncoding];
	
	//dbHandlerObj			= [[DatabaseHandler alloc]init];
	categoryListArray		= [[NSMutableArray alloc]init];
	NSMutableData *mydata	= [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString:CATEGORY_FEED_URL]];
	NSString *theXML = [[NSString alloc] initWithBytes: [mydata mutableBytes] length:[mydata length] encoding:NSASCIIStringEncoding];//NSASCIIStringEncoding];								
	NSString *theStringTrimmed = [theXML stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	
	//NSData* mydata = [[NSString stringWithFormat:@"%@",catString] dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion:YES];
	//Start Parsing
	struct  Category catDataStr; 

	//NSLog(@"mydata = %@",mydata);
	xmlParser = [[NSXMLParser alloc] initWithData:[theStringTrimmed dataUsingEncoding: NSUTF8StringEncoding]];
	xmlParser.delegate = self;
	[xmlParser setShouldResolveExternalEntities: YES];
	if([xmlParser parse])
	{
		//NSLog(@"categoryListArray123 = %@",categoryListArray);
		for (int i = 0; i < [categoryListArray count]; i ++) {
			
			[[categoryListArray objectAtIndex:i]getValue:&catDataStr];
			
			NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_GLOBAL_URL,catDataStr.categoryImageURL]]];
			NSString *imageString =  [imageData base64Encoding];
			
			NSLog(@"catDataStr ->imagedata = %@",imageString);
			if (imageString != nil) {
				
				NSString *queyString =	[NSString stringWithFormat:@"INSERT INTO %@(cat_name,cat_image) Values(\"%@\",\"%@\")",CATEGORY_TABLE_NAME,catDataStr.categoryName,imageString];
				NSLog(@"queyString = %@",queyString);

			//	[dbHandlerObj insertData:queyString];
				
			}
		}
	}
	
	
}
#pragma mark - Delegate method of XMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict
{
	
}
//@ This Function is used the Fetch the data from different functions
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// tempString Contains the data of bewwen the varous tag which are in the scope
	tempString = [[NSMutableString alloc]initWithFormat:@"%@",string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	
	if( [elementName isEqualToString:@"Category"])
	{
		categoryPtr = (struct Category *)malloc(sizeof(struct Category));
		categoryPtr->categoryName =  tempString;
		return;
	}
	
	if( [elementName isEqualToString:@"Categoryimg"])
	{
		categoryPtr->categoryImageURL = tempString;
		return;
	}
	
	
	if( [elementName isEqualToString:@"item"])
	{
		[categoryListArray addObject:[NSValue value:categoryPtr withObjCType:@encode(struct Category)]];
		
		return;
	}
	
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"parser in not working properly");
}



@end

