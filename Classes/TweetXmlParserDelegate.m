//
//  TweetXmlParserDelegate.m
//  FYI
//
//  Created by John Ryding on 11/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TweetXmlParserDelegate.h"

@implementation TweetXmlParserDelegate

@synthesize isNodeATweet, wasTweetFound;
@synthesize tweet;

-(NSMutableString *)curValue {
	if(!curValue)curValue = [[NSMutableString alloc] init];
	return curValue;
}

-(NSString *)tweet {
	if(!tweet)tweet = [[NSMutableString alloc] init];
	return tweet;
}


- (id) init	{
	if (self = [super init]) {
		[self setIsNodeATweet:NO];
		[self setWasTweetFound:NO];
	}
	
	return self;
}

- (BOOL)parseTweet:(NSData *)xmlData {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
	
	isNodeATweet = NO;
	
	[parser setDelegate:self]; // The parser calls methods in this class
	
    [parser parse]; // Parse that data..
	
	[parser setDelegate:nil];
    [parser release];
	
	return YES;
}

- (void)dealloc {
	[tweet release];
	[super dealloc];
}

//
// Methods that are required to parse the XML
//
#pragma mark NSXMLParser Delegate Calls

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (isNodeATweet && !wasTweetFound) {
		[[self curValue] appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
									 namespaceURI:(NSString *)namespaceURI 
									 qualifiedName:(NSString *)qName 
									 attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"entry"]) {
		[self setIsNodeATweet:YES];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (isNodeATweet && !wasTweetFound && [elementName isEqualToString:@"title"]) {
		[self setWasTweetFound:YES];
		[self setTweet:curValue];
	}
	
	if ([elementName isEqualToString:@"entry"]) {
		[self setIsNodeATweet:NO];
	}
	
	[[self curValue] release];
	curValue = nil;
}
@end
