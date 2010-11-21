
#import <UIKit/UIKit.h>

@interface TextPosition : UITextPosition {
    NSUInteger position;
}

@property (nonatomic, assign) NSUInteger position;

+ (id)positionWithInteger:(NSUInteger)position;

@end
