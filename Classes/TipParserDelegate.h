//
//  TipParserDelegate.h
//  FYI
//
//  Created by John Ryding on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TipItem.h"

#define TIP_NAME @"tip"
#define BODY_NAME @"body"
#define AUTHOR_NAME @"author"
#define LINK_NAME @"link"

@interface TipParserDelegate : NSObject {
	NSMutableString *curValue;
	BOOL itemElementInProgress;
	TipItem *tip;
}

@property (nonatomic, retain) NSMutableString *curValue;
@property (nonatomic, retain) TipItem *tip;
@property BOOL itemElementInProgress;

- (BOOL) parse:(NSData *)xmlData; // This performs the parsing of the file
- (id)initWithTipItem:(TipItem *)aTipItem; // Custom initializer

@end
