//
//  StudentsObject.m
//  DSLockDemo
//
//  Created by 童玉龙 on 16/9/6.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "StudentsObject.h"

@implementation StudentsObject

- (void)addStudent{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)removeStudent{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
