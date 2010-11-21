//
//  TextInputAppDelegate.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "TextInputAppDelegate.h"
#import "RootViewController.h"

@implementation TextInputAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
