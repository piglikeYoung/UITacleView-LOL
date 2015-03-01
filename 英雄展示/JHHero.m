//
//  JHHero.m
//  英雄展示
//
//  Created by piglikeyoung on 15/2/28.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//


#import "JHHero.h"

@implementation JHHero

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)heroWithDict:(NSDictionary *)dict
{
    return [[JHHero alloc] initWithDict:dict];
}

@end
