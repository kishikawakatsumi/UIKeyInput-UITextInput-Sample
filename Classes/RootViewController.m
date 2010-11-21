//
//  RootViewController.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "RootViewController.h"
#import "SimpleTextViewController.h"
#import "PasscodeLockViewController.h"
#import "CoreTextViewController.h"

@implementation RootViewController

- (void)dealloc {
    [super dealloc];
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (row == 0) {
        cell.textLabel.text = @"Simple Text View";
    } else if (row == 1) {
        cell.textLabel.text = @"Passcode Lock View";
    } else {
        cell.textLabel.text = @"Core Text View";
    }
    
    return cell;
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    
    if (row == 0) {
        SimpleTextViewController *controller = [[SimpleTextViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    } else if (row == 1) {
        PasscodeLockViewController *controller = [[PasscodeLockViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    } else {
        CoreTextViewController *controller = [[CoreTextViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}

@end
