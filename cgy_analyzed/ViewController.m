//
//  ViewController.m
//  cgy_analyzed
//
//  Created by chengangyu on 16/12/5.
//  Copyright © 2016年 tiaopi.cgy. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CGY.h"
#import "testDemo.h"
#import "testDemo_2.h"

@interface ViewController ()
{
    testDemo *test;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self create];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)create
{
    NSMutableDictionary *dic_2 = [[NSMutableDictionary alloc] init];
    [dic_2 setObject:@"demo2" forKey:@"demo2"];
    [dic_2 setObject:@"cool" forKey:@"type"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:@"cgy" forKey:@"name"];
//    [dic setObject:@(20) forKey:@"number"];
    [dic setObject:dic_2 forKey:@"demo"];
    
    test = [[testDemo alloc] initWithDictionary:dic];
    
    [test print];
}

@end
