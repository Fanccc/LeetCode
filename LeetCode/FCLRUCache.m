//
//  FCLRUCache.m
//  LeetCode
//
//  Created by fanchuan on 2021/4/26.
//

#import "FCLRUCache.h"
#import "FCLinkedModel.h"

@interface FCLRUCache ()
/// 最大容量
@property (nonatomic, assign) NSInteger capacity;
/// 当前容量
@property (nonatomic, assign) NSInteger size;
/// hash表
@property (nonatomic, strong) NSMutableDictionary *dic;

/// 使用伪头部和伪尾部节点
@property (nonatomic, strong) FCLinkedModel *head;
@property (nonatomic, strong) FCLinkedModel *tail;

@end

@implementation FCLRUCache

- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if (self) {
        _size = 0;
        _capacity = capacity;
        _dic = [NSMutableDictionary dictionary];
        _head = [[FCLinkedModel alloc] init];
        _tail = [[FCLinkedModel alloc] init];
        _head.nextValue = _tail;
        _tail.prevValue = _head;
    }
    return self;
}
/**
 LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
 int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
 void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
 */

- (NSInteger)get:(NSInteger)key {
    FCLinkedModel *node = [self.dic objectForKey:@(key)];
    if (!node) {
        return -1;
    }
    [self moveNodeToHead:node];
    return node.value;
}

- (void)put:(NSInteger)key value:(NSInteger)value {
    FCLinkedModel *node = [self.dic objectForKey:@(key)];
    if (!node) {
        //不存在,创建节点,添加到hash表中
        node = [[FCLinkedModel alloc] init];
        node.key = key;
        node.value = value;
        [self.dic setObject:node forKey:@(key)];
        self.size++;
        //添加到头部
        [self addNodeToHead:node];
        if (self.size > self.capacity) {
            FCLinkedModel *tailNode = [self removeTail];
            [self.dic removeObjectForKey:@(tailNode.key)];
            self.size--;
        }
    } else {
        node.value = value;
        //移动到头部
        [self moveNodeToHead:node];
    }

}

#pragma mark - Private
/// 移动数据源到头部
- (void)moveNodeToHead:(FCLinkedModel *)node {
    [self removeNode:node];
    [self addNodeToHead:node];
}

/// 添加到头部
- (void)addNodeToHead:(FCLinkedModel *)node {
    node.prevValue = self.head;
    node.nextValue = self.head.nextValue;
    self.head.nextValue.prevValue = node;
    self.head.nextValue = node;
}

///删除尾部元素
- (FCLinkedModel *)removeTail {
    FCLinkedModel *tailNode = self.tail.prevValue;
    [self removeNode:tailNode];
    return tailNode;
}

/// 删除元素
- (void)removeNode:(FCLinkedModel *)node {
    node.prevValue.nextValue = node.nextValue;
    node.nextValue.prevValue = node.prevValue;
}

@end
