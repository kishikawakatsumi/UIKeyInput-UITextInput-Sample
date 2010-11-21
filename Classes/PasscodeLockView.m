//
//  PasscodeLockView.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "PasscodeLockView.h"

@implementation PasscodeLockView

@synthesize textColor;
@synthesize font;
@synthesize textStore;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        self.font = [UIFont boldSystemFontOfSize:24.0f];
        self.textStore = [NSMutableString string];
        
        UIImageView *passcodeFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passcode_frame.png"]];
        passcodeFrame.frame = CGRectMake(0.0f, 40.0f, 320.0f, 96.0f);
        [self addSubview:passcodeFrame];
        [passcodeFrame release];
    }
    return self;
}

- (void)dealloc {
    self.textColor = nil;
    self.font = nil;
    self.textStore = nil;
    [super dealloc];
}

#pragma mark UIKeyInput protocol

- (BOOL)hasText {
    return textStore.length > 0;
}

- (void)insertText:(NSString *)text {
    if ([textStore length] >= 4) {
        return;
    }
    [textStore appendString:text];
    NSLog(@"%@", textStore);
    [self setNeedsDisplay];
}

- (void)deleteBackward {
    if ([textStore length] == 0) {
        return;
    }
    NSRange theRange = NSMakeRange(textStore.length - 1, 1);
    [textStore deleteCharactersInRange:theRange];
    [self setNeedsDisplay];
}

#pragma mark -

- (void)drawRect:(CGRect)rect {
    [textColor set];
    for (int i = 0; i < [textStore length]; i++) {
        NSString *altText = [NSString stringWithUTF8String:"●"];
        [altText drawAtPoint:CGPointMake(45.0f + 71.0f * i, 71.0f) withFont:font];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self becomeFirstResponder];
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

@end
