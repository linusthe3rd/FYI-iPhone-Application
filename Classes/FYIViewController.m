//
//  FYIViewController.m
//  FYI
//
//  Created by John Ryding on 10/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FYIViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FYIViewController

//tells compiler to auto-generate setters and getters for the given property 
@synthesize tipText, spinner;

-(HttpClient *)client {
	if(!client)client = [[HttpClient alloc] init];
	return client;
}

-(TipParserDelegate *)parser {
	if(!parser)parser = [[TipParserDelegate alloc] init];
	return parser;
}

//an init method that gets fired after the nib is loaded and all objects are initialized
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	//add a corner radius to the UILabel
	self.tipText.layer.cornerRadius = 8;
	
	[self.tipText setHidden:YES];	
	[self.spinner startAnimating];
	
	[self getTip];
	//[[self client] getTweet:self];
}

-(IBAction) buttonPressed:(id)sender {
	self.tipText.text = @"";
	[self.spinner startAnimating];
	[self.tipText setHidden:YES];
	
	[self getTip];
	//[[self client] getTweet:self];
}

-(void) getTip{
	[[self client] getRequest:FYI_RANDOM_URI callbackObj:self];
}

- (void) updateText:(NSMutableData *)xmlData {
	TipItem *tip = [[TipItem alloc] init];
	
	[[self parser] setTip:tip];
	[[self parser] parse:xmlData];
	
	CGSize maximumSize = CGSizeMake(300, 9999);
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:18];
	CGSize stringSize = [tip.body sizeWithFont:font 
								 constrainedToSize:maximumSize 
								 lineBreakMode:self.tipText.lineBreakMode];
	
	CGRect textFrame = CGRectMake(10, 18, 300, stringSize.height+50);
	
	[self.spinner stopAnimating];	
	[self.tipText setHidden:NO];
	self.tipText.frame = textFrame;
	self.tipText.text = tip.body;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.tipText = nil;
}


- (void)dealloc {
	[client release];
	[tipText release];
    [super dealloc];
}

@end
