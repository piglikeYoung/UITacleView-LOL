//
//  JHHero.h
//  英雄展示
//
//  Created by piglikeyoung on 15/2/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHHero:NSObject

/** 头像 */
@property (nonatomic, copy) NSString *icon;

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 描述 */
@property (nonatomic, copy) NSString *intro;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)heroWithDict:(NSDictionary *)dict;

@end
