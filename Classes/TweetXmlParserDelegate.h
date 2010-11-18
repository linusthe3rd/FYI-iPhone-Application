//
//  TweetXmlParserDelegate.h
//  FYI
//
//  Created by John Ryding on 11/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TweetXmlParserDelegate : NSObject {
	BOOL isNodeATweet;
	BOOL wasTweetFound;
	NSMutableString *curValue;
	NSString *tweet;
}

@property (nonatomic, retain) NSString *tweet;
@property BOOL isNodeATweet;
@property BOOL wasTweetFound;

- (BOOL)parseTweet:(NSData *)xmlData;

@end
