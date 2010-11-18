//
//  HttpClient.m
//  FYI
//
//  Created by John Ryding on 11/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpClient.h"


@implementation HttpClient

@synthesize responseData, callbackObj;

-(void)getRequest:(NSString *)uri callbackObj:(NSObject *)callbackObjParam{
	//set the callback object
	self.callbackObj = callbackObjParam;
	
	//setup the HTTP Request
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:uri]];
	[request setValue:@"text/xml" forHTTPHeaderField:@"Accept"];
	NSURLConnection	*connection = [[NSURLConnection alloc] initWithRequest:request 
																  delegate:self];
	
	if (connection) {
		NSMutableData *data = [[NSMutableData alloc] init];
		self.responseData = data;
		[data release];
	}
	
	[request release];
}

-(void)displayError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
													message:[NSString stringWithFormat:@"Connection failed! Error"]
													delegate:self
										  cancelButtonTitle:@"Bummer"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)dealloc {
	[responseData release];
	[callbackObj release];
    [super dealloc];
}

//
// Methods that are required to manage asynchronous requests
//
#pragma mark -
#pragma mark NSURLConnection Callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	self.responseData = nil;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
													message:[NSString stringWithFormat:@"Connection failed! Error - %@ (URL: %@)",[error localizedDescription],[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]]
													delegate:self
										  cancelButtonTitle:@"Bummer"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//execute the "updateText" method on the callback object
	
	NSString* returnString= [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
	NSLog(returnString);
	
		   
		   
		   
	[self.callbackObj performSelector:@selector(updateText:) withObject:responseData];
	
	
	
//	BOOL wasParseSuccessful = [[self parser] parseTweet:responseData];
//	
//	if (wasParseSuccessful) {
//		
//	} else {
//		[self.callbackObj performSelector:@selector(displayError)];
//	}
}

@end
