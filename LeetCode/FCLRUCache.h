//
//  FCLRUCache.h
//  LeetCode
//
//  Created by fanchuan on 2021/4/26.
//

#import <Foundation/Foundation.h>

@interface FCLRUCache : NSObject

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (NSInteger)get:(NSInteger)key;

- (void)put:(NSInteger)key value:(NSInteger)value;

@end
