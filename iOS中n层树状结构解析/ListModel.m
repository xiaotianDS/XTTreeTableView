//
//  ListModel.m
//  iOS中n层树状结构解析
//
//  Created by a on 16/10/20.
//  Copyright © 2016年 a. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _name = [dict[@"name"] isKindOfClass:[NSString class]] ? dict[@"name"] : @"";

        _nameId = [dict[@"id"] isKindOfClass:[NSNumber class]] ? dict[@"id"] : @0;
        _isExpand = NO;

        NSMutableArray <ListModel *>* mutableArray = [NSMutableArray array];
        if ([dict[@"subList"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in dict[@"subList"]) {
                ListModel *model = [[ListModel alloc] initWithDict:dic];   //递归创建直到subList为空才停止
                model.superModel = self;
                model.level = ++_level;
                model.isExpand = NO;
                [mutableArray addObject:model];
            }
        }
        _subList = [mutableArray copy];

    }
    return self;
}

+ (instancetype)listModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
