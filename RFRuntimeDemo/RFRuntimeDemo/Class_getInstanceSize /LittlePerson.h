//
//  LittlePerson.h
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LittlePerson : NSObject
/** 学校 */
@property (nonatomic, copy) NSString *school;
/** 玩具 */
@property (nonatomic, strong) NSArray *toys;
/** 书 */
@property (nonatomic, assign) short bookCount;


@end

NS_ASSUME_NONNULL_END
