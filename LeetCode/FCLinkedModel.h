//
//  FCLinkedModel.h
//  LeetCode
//
//  Created by fanchuan on 2021/4/20.
//

//链表对象
#import <Foundation/Foundation.h>

@interface FCLinkedModel : NSObject

@property (nonatomic, assign) NSInteger key;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) FCLinkedModel *prevValue;

@property (nonatomic, strong) FCLinkedModel *nextValue;

@end
