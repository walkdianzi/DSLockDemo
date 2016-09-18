//
//  NSConditionLockViewController.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "NSConditionLockViewController.h"

@implementation NSConditionLockViewController

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
    NSConditionLock *theLock = [[NSConditionLock alloc] init];

    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i=0;i<=2;i++)
        {
            [theLock lock];
            NSLog(@"thread1:%d",i);
            sleep(2);
            [theLock unlockWithCondition:i];
        }
    });

    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [theLock lockWhenCondition:2];
        NSLog(@"thread2");
        [theLock unlock];
    });
}

@end
