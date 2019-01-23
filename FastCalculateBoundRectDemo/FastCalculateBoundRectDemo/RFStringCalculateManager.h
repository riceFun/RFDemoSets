//
//  RFStringCalculateManager.h
//  FastCalculateBoundRectDemo
//
//  Created by riceFun on 2019/1/22.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RFStringCalculateManager : NSObject
+(instancetype)sharedInstance;

#pragma mark public
//限定最大行数的场景下计算label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font maxLine:(int)maxLine;

//行数不限的场景下计算Label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font;

//限定最大高度的场景下计算Label的bounds
-(CGRect)fastCalculateSizeWithString:(NSString *)string maxSize:(CGSize)maxSize font:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
