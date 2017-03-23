//
//  ViewController.m
//  iOS中n层树状结构解析
//
//  Created by a on 16/10/20.
//  Copyright © 2016年 a. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

#import "XTTreeTableView.h"
#import "ListModel.h"

@interface ViewController ()<XTTreeTableCellDelegate>

{
    XTTreeTableView *_tableView;
}

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSDictionary *dict = @{
                           @"list": @[
                                    @{
                                        @"name": @"first",
                                        @"id": @1,
                                        @"subList": @[
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2
                                                    },
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2
                                                    }
                                                    ]
                                    },
                                    @{
                                        @"name": @"first",
                                        @"id": @1,
                                        @"subList": @[
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2,
                                                        @"subList": @[
                                                                    @{
                                                                        @"name": @"third",
                                                                        @"id": @3
                                                                    },
                                                                    @{
                                                                        @"name": @"third",
                                                                        @"id": @3
                                                                    }
                                                                    ]
                                                    },
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2,
                                                        @"subList": @[
                                                                    @{
                                                                        @"name": @"third",
                                                                        @"id": @3
                                                                    },
                                                                    @{
                                                                        @"name": @"third",
                                                                        @"id": @3
                                                                    }
                                                                    ]
                                                    }
                                                    ]
                                    },
                                    @{
                                        @"name": @"first",
                                        @"id": @1,
                                        @"subList": @[
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2
                                                    },
                                                    @{
                                                        @"name": @"second",
                                                        @"id": @2
                                                    }
                                                    ]
                                    }
                                    ]
                           };


    NSArray *arr = dict[@"list"];

    NSMutableArray *arrM = [NSMutableArray array];

    for (NSDictionary *dict in arr) {

        ListModel *model = [ListModel listModelWithDict:dict];

        [arrM addObject:model];
    }

    self.dataSource = arrM;


    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH/2, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2, 0, WIDTH/2, 50)];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    [self createTabelView];

}

- (void)btnClick
{
    NSLog(@"data = %@",self.dataSource);
}

- (void)btn1Click
{
    ListModel *model = self.dataSource[1];
    ListModel *subModel = model.subList[0];
    NSLog(@"data1 = %@",subModel);
}


- (void)createTabelView
{
    _tableView = [[XTTreeTableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT-50) withData:self.dataSource];
    _tableView.treeTableCellDelegate = self;
//    self.mainTable.backgroundColor = [UIColor redColor];
//    self.mainTable.delegate = self;
//    self.mainTable.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)cellClick:(ListModel *)model
{
    NSLog(@"name = %@\ncount = %ld",model.name,model.subList.count);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


@{@"list": @[@{@"name": @"first",@"id": @1,
              @"subList":
                       @[@{@"name": @"second",@"id": @2},@{@"name": @"second",@"id": @2}]},
                 @{@"name": @"first",@"id": @1,
                   @"subList": @[@{@"name": @"second",@"id": @2,@"subList": @[@{@"name": @"third",@"id": @3},
                                                           @{
                                                               @"name": @"third",
                                                               @"id": @3
                                                               }
                                                           ]
                                                   },
                                               @{
                                                   @"name": @"second",
                                                   @"id": @2,
                                                   @"subList": @[
                                                           @{
                                                               @"name": @"third",
                                                               @"id": @3
                                                               },
                                                           @{
                                                               @"name": @"third",
                                                               @"id": @3
                                                               }
                                                           ]
                                                   }
                                               ]
                                       },
                                   @{
                                       @"name": @"first",
                                       @"id": @1,
                                       @"subList": @[
                                               @{
                                                   @"name": @"second",
                                                   @"id": @2
                                                   },
                                               @{
                                                   @"name": @"second",
                                                   @"id": @2
                                                   }
                                               ]
                                       }
                                   ]
                           };


}

@end
