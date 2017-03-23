//
//  XTTreeTableView.m
//  iOS中n层树状结构解析
//
//  Created by a on 16/10/20.
//  Copyright © 2016年 a. All rights reserved.
//

#import "XTTreeTableView.h"

#import "ListModel.h"

@interface XTTreeTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSArray *data;//传递过来已经组织好的数据（最外层的Model）

@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（需要展示的数据）

@end

@implementation XTTreeTableView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        _data = data;
        _tempData = [NSMutableArray arrayWithArray:data];//[self createTempData:data];
    }
    return self;
}

///**
// * 初始化数据源
// */
//- (NSMutableArray *)createTempData:(NSArray *)data
//{
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELL_ID = @"XTTree";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }

    ListModel *model = self.tempData[indexPath.row];
    cell.textLabel.text = model.name;

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先修改数据源
    ListModel *parentModel = self.tempData[indexPath.row];
    if (_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(cellClick:)]) {
        [_treeTableCellDelegate cellClick:parentModel];
    }

    NSInteger startPosition = indexPath.row + 1;
    NSInteger endPosition = startPosition;
    BOOL expand = NO;

    if (parentModel.subList.count) {

        parentModel.isExpand = !parentModel.isExpand;

        if (parentModel.isExpand) {//如果展开
            for (int i = 0; i < parentModel.subList.count; i ++) {
                ListModel *subModel = parentModel.subList[i];
                [self.tempData insertObject:subModel atIndex:endPosition];
                endPosition ++;
            }
            expand = YES;
        } else {
            expand = NO;
            endPosition = [self removeAllModelsAtSupModel:parentModel];
        }

    }

    //获得需要修正的indexPath
    NSMutableArray *indexPathArr = [NSMutableArray array];
    for (NSInteger i = startPosition; i < endPosition; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArr addObject:indexPath];
    }

    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArr withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [self deleteRowsAtIndexPaths:indexPathArr withRowAnimation:UITableViewRowAnimationNone];
    }

}

- (NSInteger)removeAllModelsAtSupModel:(ListModel *)supModel
{
    NSInteger startPosition = [self.tempData indexOfObject:supModel];

    CGFloat count;
    for (int i = 0; i < supModel.subList.count; i ++) {
        ListModel *model = supModel.subList[i];
        count ++;
        if (model.isExpand) {
            count += model.subList.count;
            model.isExpand = NO;
        }

    }

    NSInteger endPosition = startPosition + count + 1;//supModel.subList.count + 1;

    [self.tempData removeObjectsInRange:NSMakeRange(startPosition+1, count)];

    return endPosition;

}


@end
