
#import <Foundation/Foundation.h>
#import "TextPosition.h"

@interface TextRange : UITextRange <NSCopying> {
@private
    UITextPosition *start;
    UITextPosition *end;
}

+ (id)rangeWithStart:(TextPosition *)startPosition end:(TextPosition *)endPosition;
- (void)setStartPostion:(TextPosition *)position;
- (void)setEndPostion:(TextPosition *)position;
- (int)length;

@end
