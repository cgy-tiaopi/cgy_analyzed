//
//  testDemo.h
//  cgy_analyzed
//
//  Created by chengangyu on 16/12/6.
//  Copyright © 2016年 tiaopi.cgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "testDemo_2.h"

@interface testDemo : NSObject

@property (nonatomic, strong) NSString *name;
//
////@property (nonatomic, assign) BOOL     type;
////
////@property (nonatomic, assign) NSInteger age;
//
//@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) testDemo_2 *demo;

- (void)print;


@end
