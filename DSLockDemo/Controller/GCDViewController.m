//
//  GCDViewController.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "GCDViewController.h"
#import "StudentsObject.h"

@implementation GCDViewController

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
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [obj addStudent];
        sleep(3);
        dispatch_semaphore_signal(semaphore);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [obj removeStudent];
        dispatch_semaphore_signal(semaphore);
    });
}


@end
