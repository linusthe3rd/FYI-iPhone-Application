//
//  FYIAppDelegate.h
//  FYI
//
//  Created by John Ryding on 10/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYIViewController;

@interface FYIAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FYIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FYIViewController *viewController;

@end

