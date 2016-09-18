//
//  NSLockViewController.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "NSLockViewController.h"
#import "StudentsObject.h"

@implementation NSLockViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"begin" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testBegin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}


- (void)testBegin{
    
    //主线程中
    StudentsObject *obj = [[StudentsObject alloc] init];
    NSLock *thelock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [thelock lock];
        [obj addStudent];
        sleep(3);
        [thelock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [thelock lock];
        [obj removeStudent];
        [thelock unlock];
    });
}

@end
