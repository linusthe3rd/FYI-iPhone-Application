//
//  FYIViewController.h
//  FYI
//
//  Created by John Ryding on 10/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"HttpClient.h"
#import "TipParserDelegate.h"
#import "TipItem.h"

#define FYI_RANDOM_URI @"http://fyi.somewhatgeeky.com/tip/random"

@interface FYIViewController : UIViewController {
	IBOutlet UILabel *tipText;
	IBOutlet UIActivityIndicatorView *spinner;
	HttpClient *client;
	TipParserDelegate *parser;
}

//code reference of a UILabel from Interface Builder that is connected
//by linking up the FileOwner to a UILabel
@property (nonatomic, retain) IBOutlet UILabel *tipText;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction) buttonPressed:(id)sender;
- (void) getTip;
- (void) updateText:(NSMutableData *)data;

@end

