//
//  Tip.m
//  FYI
//
//  Created by John Ryding on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TipItem.h"


@implementation TipItem

@synthesize body;
@synthesize author;
@synthesize link;

-(void) dealloc {
	[body release];
	[author release];
	[link release];
	
	[super dealloc];
}
@end
