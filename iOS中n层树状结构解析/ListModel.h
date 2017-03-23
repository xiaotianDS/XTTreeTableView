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
@property(nonatomic,copy)NSArray<ListModel *> *subList;//子类Model的数组
@property(nonatomic,assign)BOOL isExpand;//是否展开的状态

@property(nonatomic,weak)ListModel *superModel;//父类Model
@property(nonatomic,assign)int level;//当前Model所在的层级（第几级的Model）

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)listModelWithDict:(NSDictionary *)dict;

@end
