//
//  HttpClient.h
//  FYI
//
//  Created by John Ryding on 11/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipParserDelegate.h"

#define TWITTER_SEARCH_URI  @"http://search.twitter.com/search.atom?q=pirates"

#define REQUEST_URI TWITTER_SEARCH_URI


@interface HttpClient : NSObject {
	NSMutableData *responseData;
	NSObject *callbackObj;
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSObject *callbackObj;

-(void)getRequest:(NSString *)uri callbackObj:(NSObject *)callbackObjParam;

@end
