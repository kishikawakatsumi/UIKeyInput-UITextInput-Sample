//
//  SimpleTextView.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "SimpleTextView.h"

@implementation SimpleTextView

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
    NSLog(@"%s", __func__);
    NSLog(@"%@", text);
    [textStore appendString:text];
    [self setNeedsDisplay];
}

- (void)deleteBackward {
    NSLog(@"%s", __func__);
    if ([textStore length] == 0) {
        return;
    }
    
    NSRange theRange = NSMakeRange(textStore.length - 1, 1);
    [textStore deleteCharactersInRange:theRange];
    [self setNeedsDisplay];
}

#pragma mark -

- (CGRect)rectForTextWithInset:(CGFloat)inset {
    return CGRectInset(self.bounds, inset, inset);
}

- (void)drawRect:(CGRect)rect {
    CGRect rectForText = [self rectForTextWithInset:8.0f];
    [textColor set];
    UIRectFrame(rect);
    [textStore drawInRect:rectForText withFont:font];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self becomeFirstResponder];
}

@end
