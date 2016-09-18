//
//  NSRecursiveLockViewController.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "NSRecursiveLockViewController.h"
#import "StudentsObject.h"

@implementation NSRecursiveLockViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *falseBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 60)];
    falseBtn.backgroundColor = [UIColor redColor];
    [falseBtn setTitle:@"deadLock" forState:UIControlStateNormal];
    [falseBtn addTarget:self action:@selector(falseBegin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:falseBtn];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 150, 60)];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setTitle:@"No deadLock" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBegin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightBtn];
}


- (void)falseBegin{
    
    //主线程中
    StudentsObject *obj = [[StudentsObject alloc] init];
    NSLock *thelock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^TestMethod)(int);
        TestMethod = ^(int value)
        {
            [thelock lock];
            if (value > 0)
            {
                [obj addStudent];
                sleep(3);
                TestMethod(value-1);
            }
            [thelock unlock];
        };
        
        TestMethod(5);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        [thelock lock];
        [obj removeStudent];
        [thelock unlock];
    });
}

- (void)rightBegin{
    
    //主线程中
    StudentsObject *obj = [[StudentsObject alloc] init];
    NSRecursiveLock *thelock = [[NSRecursiveLock alloc] init];

    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^TestMethod)(int);
        TestMethod = ^(int value)
        {
            [thelock lock];
            if (value > 0)
            {
                [obj addStudent];
                sleep(3);
                TestMethod(value-1);
            }
            [thelock unlock];
        };
        
        TestMethod(5);
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
