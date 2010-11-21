
#import "TextPosition.h"

@implementation TextPosition

@synthesize position;

+ (id)positionWithInteger:(NSUInteger)pos {
    TextPosition *e = [[TextPosition alloc] init];
    e.position = pos;
    return [e autorelease];
}

@end
