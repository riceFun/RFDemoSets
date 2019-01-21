//
//  Dog.h
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/17.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject//strong、weak或unsafe_unretained类型，在属性的最后加上了s、w、un来区分。
@property (nonatomic, strong) id property_1_s;
@property (nonatomic, weak) id property_2_w;
@property (nonatomic, unsafe_unretained) id property_3_un;
@property (nonatomic, weak) id property_4_w;
@property (nonatomic, strong) id property_5_s;
@property (nonatomic, strong) id property_6_s;
@property (nonatomic, unsafe_unretained) id property_7_un;
@property (nonatomic, strong) id property_8_s;
@property (nonatomic, strong) id property_9_s;
@property (nonatomic, weak) id property_10_w;
@property (nonatomic, weak) id property_11_w;
@property (nonatomic, strong) id property_12_s;

// 在刚才的property_12_s属性后添加
/** ----------我是分割线---------- */
@property (nonatomic, assign) int property_13_int;
@property (nonatomic, assign) short property_14_short;
@property (nonatomic, weak) id property_15_w;
@property (nonatomic, assign) char property_16_char;
@property (nonatomic, strong) id property_17_s;


@end

NS_ASSUME_NONNULL_END
