//
//  XTTreeTableView.h
//  iOS中n层树状结构解析
//
//  Created by a on 16/10/20.
//  Copyright © 2016年 a. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;

@protocol XTTreeTableCellDelegate <NSObject>

- (void)cellClick:(ListModel *)model;

@end

@interface XTTreeTableView : UITableView

@property(nonatomic,weak)id<XTTreeTableCellDelegate> treeTableCellDelegate;


/**
 创建XTTreeTableView的私有方法

 @param frame tableView的位置
 @param data tableView待展示的数据源
 @return XTTreeTableView
 */
-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data;

@end
