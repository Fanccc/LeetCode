//
//  FCBinaryTreeModel.h
//  LeetCode
//
//  Created by fanchuan on 2021/4/21.
//

//二叉树
#import <Foundation/Foundation.h>

@interface FCBinaryTreeModel : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) FCBinaryTreeModel *leftNode;
@property (nonatomic, strong) FCBinaryTreeModel *rightNode;

@end
