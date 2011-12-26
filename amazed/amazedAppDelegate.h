//
//  amazedAppDelegate.h
//  amazed
//
//  Created by Steven Lotito on 12/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class amazedViewController;

@interface amazedAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet amazedViewController *viewController;

@end
