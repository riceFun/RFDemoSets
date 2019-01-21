//
//  NSObject+Hook.h
//  RFKVODemo2
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Hook)
+ (void)hookWithInstance:(id)instance method:(SEL)selector newclass:(Class)targetClass;
@end

NS_ASSUME_NONNULL_END
