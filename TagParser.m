//
//  TagParser.m
//  City Guide
//
//  Created by Gaurav Sinha on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TagParser.h"


@implementation TagParser

//Start parser
- (void)startTagParser
{
	
	NSMutableData *mydata	= [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString:TAGFEED_URL]];
	NSString *theXML = [[NSString alloc] initWithBytes: [mydata mutableBytes] length:[mydata length] encoding:NSASCIIStringEncoding];//NSASCIIStringEncoding];								
	NSString *theStringTrimmed = [theXML stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	//Initialize the dictionary
	tagListArray = [[NSMutableArray alloc]init];
	
	struct Tag tagDataStr;
	///dbHandlerObj = [[DatabaseHandler alloc]init];

	//Start Parsing
	xmlParser = [[NSXMLParser alloc] initWithData:[theStringTrimmed dataUsingEncoding: NSUTF8StringEncoding]];
	xmlParser.delegate = self;
	[xmlParser setShouldResolveExternalEntities: YES];
	if([xmlParser parse])
	{
		NSLog(@"categoryListArray123 = %@",tagListArray);
		for (int i = 0; i < [tagListArray count]; i ++) {
			
			[[tagListArray objectAtIndex:i]getValue:&tagDataStr];
			
			NSLog(@"catDataStr.categoryImageURL =%@",tagDataStr.tagImageURL);
			NSData *imagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_GLOBAL_URL,tagDataStr.tagImageURL]]];
			NSString *imageString =  [imagedata base64Encoding];
			
			if (imageString != nil) {
				
				NSString *queyString =	[NSString stringWithFormat:@"INSERT INTO %@(tag_name,tag_image) Values(\"%@\",\"%@\")",TAG_TABLE_NAME,tagDataStr.tagName,imageString];
				NSLog(@"queyString = %@",queyString);
				
				//[dbHandlerObj insertData:queyString];
				
			}
		}
	}
	
}
#pragma mark - Delegate method of XMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict
{
	//if( [elementName isEqualToString:@"item"])
	//{
	//	// Get the Key for dictionary
	//	dictKey = [[NSString alloc]initWithFormat:@"%@",[attributeDict objectForKey:@"name"]];
	//	[newsPaperNameArray addObject:dictKey];
	//	
	//	//NSLog(@"dictKey = %@",dictKey);
	//	newsPaperArray = [[NSMutableArray alloc]init];
	//	
	//}
}
//@ This Function is used the Fetch the data from different functions
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// tempString Contains the data of bewwen the varous tag which are in the scope
	tempString = [[NSMutableString alloc]initWithFormat:@"%@",string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	
	if( [elementName isEqualToString:@"Tag"])
	{
		tagPtr = (struct Tag *)malloc(sizeof(struct Tag));
		tagPtr->tagName =  tempString;
		return;
	}
	
	if( [elementName isEqualToString:@"Tagimg"])
	{
		tagPtr->tagImageURL = tempString;
		return;
	}
	
	if( [elementName isEqualToString:@"item"])
	{
		[tagListArray addObject:[NSValue value:tagPtr withObjCType:@encode(struct Tag)]];
		return;
	}
	
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	
	NSLog(@"parser in not working properly");
}



@end

