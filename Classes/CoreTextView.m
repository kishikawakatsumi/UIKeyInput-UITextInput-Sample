//
//  CoreTextView.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "CoreTextView.h"
#import "TextPosition.h"
#import "TextRange.h"

@implementation CoreTextView

@synthesize textColor;
@synthesize font;
@synthesize textStore;
@synthesize currentMarkedText;

@synthesize inputDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        self.font = [UIFont boldSystemFontOfSize:24.0f];
        self.textStore = [NSMutableString string];
        self.currentMarkedText = [NSMutableString string];
		UITextRange *range = [TextRange rangeWithStart:[TextPosition positionWithInteger:0] 
                                                   end:[TextPosition positionWithInteger:0]];
		[self setSelectedTextRange:range];
    }
    return self;
}

- (void)dealloc {
    self.textColor = nil;
    self.font = nil;
    self.textStore = nil;
    self.currentMarkedText = nil;
    [super dealloc];
}

#pragma mark -

- (CGRect)rectForTextWithInset:(CGFloat)inset {
    return CGRectInset(self.bounds, inset, inset);
}

- (void)drawRect:(CGRect)rect {
    CGRect rectForText = [self rectForTextWithInset:8.0f];
    [self.textColor set];
    UIRectFrame(rect);
    
    NSString *drawText = [NSString stringWithFormat:@"%@%@", textStore, currentMarkedText];
    [drawText drawInRect:rectForText withFont:font];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

#pragma mark UIKeyInput protocol

- (BOOL)hasText {
    return textStore.length > 0;
}

- (void)insertText:(NSString *)text {
    NSLog(@"%s", __func__);
    NSLog(@"%@", text);
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setMenuVisible:NO animated:YES];
    
    [self.inputDelegate textWillChange:self];

    [self.textStore appendString:text];
    
    [self.inputDelegate textDidChange:self];
    
    [self setNeedsDisplay];
}

- (void)deleteBackward {
    NSLog(@"%s", __func__);
    if ([textStore length] == 0) {
        return;
    }
    
    NSRange theRange = NSMakeRange(self.textStore.length - 1, 1);
    [self.textStore deleteCharactersInRange:theRange];
    
    // Place the selection at begining of deletion range.
    TextPosition *c = [TextPosition positionWithInteger: theRange.location ];
    UITextRange *newRange = [TextRange rangeWithStart:c end:c];
    [self setSelectedTextRange:newRange];
    
    [self setNeedsDisplay];
}

#pragma mark UITextInput protocol
#pragma mark Methods for manipulating text

- (NSString *)textInRange:(UITextRange *)range {
    NSLog(@"%s", __func__);
    
//    NSUInteger length = [(TextPosition *)range.end position] - [(TextPosition *)range.start position];
//    return [self.textStore substringWithRange:NSMakeRange([(TextPosition *)range.start position], length)];
    return self.textStore;
}

- (void)replaceRange:(UITextRange *)range withText:(NSString *)text {
    NSLog(@"%s", __func__);
    
    [self.inputDelegate textWillChange:self];
    
    // Replace the characters in the string
    NSUInteger start = [(TextPosition *)range.start position];
    NSUInteger length = [(TextPosition *)range.end position] - start;
    [self.textStore replaceCharactersInRange:NSMakeRange(start, length) withString:text];	
    
    // Place caret at the end of the previously selected text.
    TextPosition *c = [TextPosition positionWithInteger: start + [text length]];
    UITextRange *newRange = [TextRange rangeWithStart:c  end:c];
    [self setSelectedTextRange:newRange];
    
    [self.inputDelegate textDidChange:self];
    
    [self setNeedsDisplay];
}

- (void)setSelectedTextRange:(UITextRange *)aSelectedTextRange {
    NSLog(@"%s", __func__);
    
    [self.inputDelegate selectionWillChange:self];
    
    selectedTextRange = [[aSelectedTextRange copy] retain];
    
    [self.inputDelegate selectionDidChange:self];
    
    [self setNeedsDisplay];
}

- (UITextRange *)selectedTextRange {
    NSLog(@"%s", __func__);
    return [TextRange rangeWithStart:[TextPosition positionWithInteger:0] end:[TextPosition positionWithInteger:[currentMarkedText length]]];
}

- (UITextRange *)markedTextRange; {
    NSLog(@"%s", __func__);
    return nil;
}

- (void)setMarkedTextStyle:(NSDictionary *)style {
    NSLog(@"%s", __func__);
    NSLog(@"%@", style);
}

- (NSDictionary *)markedTextStyle {
    NSLog(@"%s", __func__);
    return nil;
}

- (void)setMarkedText:(NSString *)markedText selectedRange:(NSRange)selectedRange {
    NSLog(@"%s", __func__);
    NSLog(@"markedText: %@  selectedRange: %@", markedText, NSStringFromRange(selectedRange));
    
    self.currentMarkedText = markedText;
    currentMarkedSelectedRange = selectedRange;
    
    [self setNeedsDisplay];
}

- (void)unmarkText {
    NSLog(@"%s", __func__);
    [textStore appendString:currentMarkedText];
    self.currentMarkedText = [NSMutableString string];
    currentMarkedSelectedRange = NSMakeRange(NSNotFound, 0);
}

#pragma mark Positions

- (UITextPosition *)beginningOfDocument; {
    NSLog(@"%s", __func__);
    return [TextPosition positionWithInteger:0];
}
- (UITextPosition *)endOfDocument {
    NSLog(@"%s", __func__);
    return [TextPosition positionWithInteger:[self.textStore length] - 1];
}

#pragma mark Methods for creating ranges and positions.

- (UITextRange *)textRangeFromPosition:(UITextPosition *)fromPosition toPosition:(UITextPosition *)toPosition {
    NSLog(@"%s", __func__);
    return [TextRange rangeWithStart:(TextPosition *)fromPosition end:(TextPosition *)toPosition];
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position offset:(NSInteger)offset {
    NSLog(@"%s", __func__);
    TextPosition *p = (TextPosition *)position;
    return [TextPosition positionWithInteger:[p position] + offset];
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
    NSLog(@"%s", __func__);
    // For arrow keys on a kayboard the start position is the same but indicates and offset for the number of times it was pressed.
    NSUInteger pos = [(TextPosition *)position position];
    
    NSLog(@"start position: %d, direction: %d, offset:%d", pos, direction, offset);
    
    switch (direction) {
        case UITextLayoutDirectionUp:
        {
            CGRect caretRect = [self caretRectForPosition:position]; // original position, not current.
            CGPoint target = caretRect.origin;
            target.y = target.y - ( caretRect.size.height * (offset - 1) ) - (caretRect.size.height * 0.5f); // half way through "previous" line.
            pos = [(TextPosition *)[self closestPositionToPoint:target] position];
            
            break;
        }
        case UITextLayoutDirectionDown:
        {
            CGRect caretRect = [self caretRectForPosition:position];
            CGPoint target = caretRect.origin;
            target.y = target.y + ( caretRect.size.height * (offset - 1) ) + (caretRect.size.height * 1.5f); // half way through "next" line.
            pos = [(TextPosition *)[self closestPositionToPoint:target] position];
            
            break;
        }
        case UITextLayoutDirectionLeft:
        {
            pos = [(TextPosition *)position position] - offset;
            
            break;
        } 
        case UITextLayoutDirectionRight:
        {
            
            pos = [(TextPosition *)position position] + offset;
            
            break;
        }
        default:
            break;
    }
    
    NSLog(@"new position: %d", pos);
    
    // This method is called with the arrow key presses. Not sure if this should
    // go here but it works.
    TextPosition *c = [TextPosition positionWithInteger: pos];
    UITextRange *newRange = [TextRange rangeWithStart:c  end:c];
    [self setSelectedTextRange:newRange];
    
    return [TextPosition positionWithInteger:pos];
}

- (NSComparisonResult)comparePosition:(UITextPosition *)position toPosition:(UITextPosition *)other {
    NSLog(@"%s", __func__);
    /*
     NSOrderedAscending
     The left operand is smaller than the right operand.
     Available in iPhone OS 2.0 and later.
     Declared in NSObjCRuntime.h.
     
     NSOrderedSame
     The two operands are equal.
     Available in iPhone OS 2.0 and later.
     Declared in NSObjCRuntime.h.
     
     NSOrderedDescending
     The left operand is greater than the right operand.
     Available in iPhone OS 2.0 and later.
     Declared in NSObjCRuntime.h.
     */
    
    int a = [(TextPosition *)position position];
    int b = [(TextPosition *)other position];
    
    NSComparisonResult result;
    if ( a < b ) result = NSOrderedAscending;
    else if ( a > b ) result = NSOrderedDescending;
    else result = NSOrderedSame;
    
    NSLog(@"a: %d b: %d result: %d",a,b,result);
    
    return result;
}
- (NSInteger)offsetFromPosition:(UITextPosition *)from toPosition:(UITextPosition *)toPosition {
    NSLog(@"%s", __func__);
    
    int a = [(TextPosition *)from position];
    int b = [(TextPosition *)toPosition position];
    NSInteger result = b - a;
    
    NSLog(@"from: %d to: %d result: %d",a,b,result);
    
    return result;
}

- (id<UITextInputTokenizer>)tokenizer {
    NSLog(@"%s", __func__);
    if (tokenizer == nil) {
        tokenizer = [[[UITextInputStringTokenizer alloc] initWithTextInput:self] retain];
    }
    return tokenizer;
}

#pragma mark Layout questions.

- (UITextPosition *)positionWithinRange:(UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction {
    NSLog(@"%s", __func__);
    return nil;
}
- (UITextRange *)characterRangeByExtendingPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction; {
    NSLog(@"%s", __func__);
    return nil;
}

#pragma mark Writing direction

- (UITextWritingDirection)baseWritingDirectionForPosition:(UITextPosition *)position inDirection:(UITextStorageDirection)direction; {
    NSLog(@"%s", __func__);
    return UITextWritingDirectionLeftToRight;
}

- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(UITextRange *)range {
    NSLog(@"%s", __func__);
}

#pragma mark Geometry

- (CGRect)firstRectForRange:(UITextRange *)range {
    NSLog(@"%s", __func__);
    return CGRectNull;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    NSLog(@"%s", __func__);
    return CGRectMake(80.0f, 40.0f, 40.0f, 44.0f);
    
    float caretWidth = 2.0f;
    float caretHeight = 20.0f;
    
    return CGRectMake(0.0f, 200.0f , caretWidth, caretHeight);
}

#pragma mark Hit testing

/* JS - Find the closest position to a given point */
- (UITextPosition *)closestPositionToPoint:(CGPoint)point {
    NSLog(@"%s", __func__);    
    return [TextPosition positionWithInteger:0];
}

- (UITextPosition *)closestPositionToPoint:(CGPoint)point withinRange:(UITextRange *)range {
    NSLog(@"%s", __func__);
    return range.start;
}

- (UITextRange *)characterRangeAtPoint:(CGPoint)point {
    NSLog(@"%s", __func__);
    TextPosition *pos = (TextPosition *)[self closestPositionToPoint:point];
    return [TextRange rangeWithStart:pos end:pos];
}

#pragma mark optional methods

/* Text styling information can affect, for example, the appearance of a correction rect. */
- (NSDictionary *)textStylingAtPosition:(UITextPosition *)position inDirection:(UITextStorageDirection)direction {
    NSLog(@"%s", __func__);
    return [NSDictionary dictionary];
}

/* To be implemented if there is not a one-to-one correspondence between text positions within range and character offsets into the associated string. */
- (UITextPosition *)positionWithinRange:(UITextRange *)range atCharacterOffset:(NSInteger)offset {
    NSLog(@"%s", __func__);
    return nil;
}

- (NSInteger)characterOffsetOfPosition:(UITextPosition *)position withinRange:(UITextRange *)range {
    NSLog(@"%s", __func__);
    return 0;
}

- (UIView *)textInputView {
    return self;
}

/* Selection affinity determines whether, for example, the insertion point appears after the last
 * character on a line or before the first character on the following line in cases where text
 * wraps across line boundaries. */
- (UITextStorageDirection)selectionAffinity {
    NSLog(@"%s", __func__);
    return UITextStorageDirectionForward;
}

@end
