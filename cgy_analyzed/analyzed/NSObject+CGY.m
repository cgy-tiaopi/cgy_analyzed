//
//  NSObject+CGY.m
//  cgy_analyzed
//
//  Created by chengangyu on 16/12/5.
//  Copyright © 2016年 tiaopi.cgy. All rights reserved.
//

#import "NSObject+CGY.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

- (id)initWithDictionary:(NSDictionary *)dict
{
    self =  [self init];
    
    NSLog(@"dict = %@",dict);
    
    objc_setAssociatedObject(self, @"dict", dict, OBJC_ASSOCIATION_RETAIN);
    
    unsigned propertyCount = 0;         //存储类的属性的数量
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);     //获取类的属性列表
    
    for (int i=0; i<propertyCount ;i++)         //循环读取属性列表中的属性
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];     //获取属性名
        
        if (dict != nil)
        {
            NSString *attributeType = [self attribute_getType:dict object:property];
            
            if (true)              //判断该属性是否在字典中存在，如果存在则获取该属性的类型
            {
                NSLog(@"attribute = %@",attributeType);
                if (![[dict valueForKey:propertyName] isEqual:[NSNull null]])       //判断dict中的value是否为null
                {
                    unsigned classPropertyCount = 0;
                    
                     class_copyPropertyList([NSString class], &classPropertyCount);
                    
                    if (classPropertyCount == 0)        //如果classPropertyCount等于0，则证明该属性的类型是Foundation中的Class，不需要嵌套解析操作.
                    {
                        NSLog(@"propertyName = %@, value = %@",propertyName,[dict valueForKey:propertyName]);
                        
                        [self setValue:[dict valueForKey:propertyName] forKey:propertyName];    //将字典中的值存入到模型中去
                    }
                    else                                //反之需要进行嵌套解析
                    {
                        if ([[dict valueForKey:propertyName] isKindOfClass:[NSDictionary class]])
                        {
                            Class someclass = NSClassFromString(attributeType);
                            
                            id class = [[someclass alloc] initWithDictionary:[dict valueForKey:propertyName]];
                            
                            [self setValue:class forKey:propertyName];
                        }
                    }
                }
                else
                {
                    
                }
            }
        }
    }
    
    free(properties);
    
    return self;
}


#pragma mark - C方法

//通过C语言方法，判断当前属性的value是否为空，回传该属性的数据类型
- (NSString *)attribute_getType:(NSDictionary *)dic object:(objc_property_t )property
{
    unsigned attributesCount = 0;
    
    objc_property_attribute_t *propertyAttributes = property_copyAttributeList(property, &attributesCount);
    
    for (int i=0; i<attributesCount; i++) {
        objc_property_attribute_t propertyAttribute = propertyAttributes[i];
        
        NSString *attributeName = [NSString stringWithCString:propertyAttribute.name encoding:NSUTF8StringEncoding];
        NSString *attributeType = [NSString stringWithCString:propertyAttribute.value encoding:NSUTF8StringEncoding];
        
        if ([attributeName isEqualToString:@"T"])
        {
            if (attributeType.length >= 4)
            {
                return [attributeType substringWithRange:NSMakeRange(2, attributeType.length-3)];
            }
        }
    }
    
    return nil;
}

@end
