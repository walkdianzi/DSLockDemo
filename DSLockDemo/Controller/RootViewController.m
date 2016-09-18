//
//  RootViewController.m
//  DSCategories
//
//  Created by dasheng on 15/12/17.
//  Copyright © 2015年 dasheng. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Lock";
    _items = @{
               
               @"Lock":@[
                       
                            @"NSLock",
                            @"Synchronized",
                            @"Pthread",
                            @"GCD",
                            @"NSRecursiveLock",
                            @"NSConditionLock"
                        ],
             };
    
    _itemsName = @{
                   
                   @"Lock":@[
                           @"第一种NSLock实现的锁",
                           @"使用synchronized关键字构建的锁",
                           @"使用C语言的pthread_mutex_t实现的锁",
                           @"使用GCD来实现的”锁”",
                           @"NSRecursiveLock递归锁",
                           @"NSConditionLock条件锁"
                           ],
                   };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_items allKeys] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_items allKeys][section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectForKey:[_items allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text =  [_itemsName objectForKey:[_itemsName allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *name =  [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    NSString *className = [name stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
