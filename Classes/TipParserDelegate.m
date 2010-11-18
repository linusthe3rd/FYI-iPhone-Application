//
//  TipParserDelegate.m
//  FYI
//
//  Created by John Ryding on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TipParserDelegate.h"

@implementation TipParserDelegate
	
@synthesize curValue;
@synthesize itemElementInProgress;
@synthesize tip;

-(NSMutableString *)curValue {
	if(!curValue)curValue = [[NSMutableString alloc] init];
	return curValue;
}

- (id)initWithTipItem:(TipItem *)aTipItem{
    if (self = [super init]) {
		[self setTip:aTipItem];
		[self setItemElementInProgress:NO];
    }
    
    return self;
}

- (BOOL)parse:(NSData *)xmlData {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
	
	[parser setDelegate:self]; // The parser calls methods in this class
	
    [parser parse]; // Parse that data..
	
	[parser setDelegate:nil];
    [parser release];
	
	return YES;
}

// Make sure objects are released
-(void)dealloc{
    [curValue release];
    [tip release];
	
    [super dealloc];
}

//
// Methods that are required to parse the XML
//
#pragma mark NSXMLParser Delegate Calls

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[[self curValue] appendString:string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName 
		attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:TIP_NAME]) {
		[self setItemElementInProgress:YES];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
		namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:TIP_NAME]) {
		[self setItemElementInProgress:NO];
	}
	
	if(self.itemElementInProgress){
		if ([elementName isEqualToString:BODY_NAME]) {
			[[self tip] setBody:curValue];
		}
		
		if ([elementName isEqualToString:AUTHOR_NAME]) {
			[[self tip] setAuthor:curValue];
		}
		
		if ([elementName isEqualToString:LINK_NAME]) {
			[[self tip] setLink:curValue];
		}
	}
	
	[curValue release];
	curValue = nil;
}


@end
