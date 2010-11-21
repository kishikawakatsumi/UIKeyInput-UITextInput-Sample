#import "TextRange.h"
#import "TextPosition.h"

@implementation TextRange

+ (id)rangeWithStart:(TextPosition *)startPosition end:(TextPosition *)endPosition {
    TextRange *range = [[TextRange alloc] init];
    [range setStartPostion:startPosition];
    [range setEndPostion:endPosition];
    return [range autorelease];
}

- (BOOL)isEmpty {
    return ([(TextPosition *)end position] - [(TextPosition *)start position]) == 0;
}

- (int)length {
    return [(TextPosition *)end position] - [(TextPosition *)start position];
}

- (UITextPosition *)start {
    return start;
}

- (void)setStartPostion:(TextPosition *)position {
    start = [position retain];
}

- (UITextPosition *)end {
    return end;
}

- (void)setEndPostion:(TextPosition *)position {
    end = [position retain];
}

#pragma mark -
#pragma mark NSCopying;

- (id)copyWithZone:(NSZone *)zone {
    TextRange *copy = [[[self class] allocWithZone: zone] init];
    
    [copy setEndPostion:(TextPosition *)[self end]];
    [copy setStartPostion:(TextPosition *)[self start]];
    
    return copy;
}

@end
