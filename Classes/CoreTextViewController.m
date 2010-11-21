//
//  CoreTextViewController.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CoreTextView.h"

@implementation CoreTextViewController

- (void)dealloc {
    [super dealloc];
}

- (void)loadView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
    self.view = contentView;
    [contentView release];
    
    textView = [[CoreTextView alloc] initWithFrame:CGRectInset(contentView.frame, 20.0f, 20.0f)];
    textView.backgroundColor = [UIColor lightGrayColor];
    [contentView addSubview:textView];
    [textView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
