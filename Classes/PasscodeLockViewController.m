    //
//  PasscodeLockViewController.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "PasscodeLockViewController.h"
#import "PasscodeLockView.h"

@implementation PasscodeLockViewController

- (void)dealloc {
    [super dealloc];
}

- (void)loadView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
    self.view = contentView;
    [contentView release];
    
    passcodeView = [[PasscodeLockView alloc] initWithFrame:contentView.frame];
    passcodeView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:passcodeView];
    [passcodeView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [passcodeView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
