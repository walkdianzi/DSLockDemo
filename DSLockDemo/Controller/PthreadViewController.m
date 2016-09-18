//
//  PthreadViewController.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "PthreadViewController.h"
#import "StudentsObject.h"
#include "pthread.h"

@implementation PthreadViewController

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
    
    __block pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, NULL);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        [obj addStudent];
        sleep(3);
        pthread_mutex_unlock(&mutex);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&mutex);
        [obj removeStudent];
        pthread_mutex_unlock(&mutex);
    });
}


@end
