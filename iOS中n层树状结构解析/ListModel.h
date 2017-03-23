//
//  ListModel.h
//  iOS中n层树状结构解析
//
//  Created by a on 16/10/20.
//  Copyright © 2016年 a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *nameId;
@property(nonatomic,copy)NSNumber *nameId;
@property(nonatomic,copy)NSArray<ListModel *> *subList;
@property(nonatomic,assign)BOOL isExpand;

@property(nonatomic,weak)ListModel *superModel;
@property(nonatomic,assign)int level;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)listModelWithDict:(NSDictionary *)dict;

@end
