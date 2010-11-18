//
//  Tip.h
//  FYI
//
//  Created by John Ryding on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TipItem : NSObject {
	NSString *body;
	NSString *author;	
	NSString *link;
}

@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *link;

@end
