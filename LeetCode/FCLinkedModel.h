//
//  FCLinkedModel.h
//  LeetCode
//
//  Created by fanchuan on 2021/4/20.
//

//链表对象
#import <Foundation/Foundation.h>

@interface FCLinkedModel : NSObject

/// key
@property (nonatomic, assign) NSInteger key;

/// 值
@property (nonatomic, assign) NSInteger value;

/// 上一个元素
@property (nonatomic, strong) FCLinkedModel *prevValue;

/// 下一个元素
@property (nonatomic, strong) FCLinkedModel *nextValue;

@end
