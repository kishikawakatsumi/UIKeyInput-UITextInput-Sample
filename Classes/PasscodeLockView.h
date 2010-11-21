//
//  PasscodeLockView.h
//  TextInput
//
//  Created by Kishikawa Katsumi on 10/11/21.
//  Copyright 2010 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasscodeLockView : UIView<UIKeyInput> {
    UIColor *textColor;
    UIFont *font;
    NSMutableString *textStore;
}

@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSMutableString *textStore;

@end
