//
//  Kana.m
//  foxkana
//
//  Created by Soul on 6/3/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "Kana.h"

@implementation Kana

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}
+ (NSString *)primaryKey {
    return @"key";
}

@end
