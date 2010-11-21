//
//  TextInputStringTokenizer.m
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import "TextInputStringTokenizer.h"

@implementation TextInputStringTokenizer

- (BOOL)isPosition:(UITextPosition *)position atBoundary:(UITextGranularity)granularity inDirection:(UITextDirection)direction {
    NSLog(@"%s", __func__);
    return [super isPosition:position atBoundary:granularity inDirection:direction];
}

- (BOOL)isPosition:(UITextPosition *)position withinTextUnit:(UITextGranularity)granularity inDirection:(UITextDirection)direction {
    NSLog(@"%s", __func__);
    return [super isPosition:position withinTextUnit:granularity inDirection:direction];
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position toBoundary:(UITextGranularity)granularity inDirection:(UITextDirection)direction {
    NSLog(@"%s", __func__);
    return [super positionFromPosition:position toBoundary:granularity inDirection:direction];
}

- (UITextRange *)rangeEnclosingPosition:(UITextPosition *)position withGranularity:(UITextGranularity)granularity inDirection:(UITextDirection)direction {
    NSLog(@"%s", __func__);
    return [super rangeEnclosingPosition:position withGranularity:granularity inDirection:direction];
}

@end
