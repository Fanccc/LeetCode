//
//  ViewController.m
//  LeetCode
//
//  Created by fanchuan on 2021/4/20.
//

#import "FCReviewViewController.h"
#import "FCLinkedModel.h"
#import "FCBinaryTreeModel.h"
#import "FCLRUCache.h"

@interface FCReviewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *tableListArray;

@end

@implementation FCReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 两数之和
//时间复杂度：O(N)
- (void)twoNumber:(NSInteger)target array:(NSArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *result = [NSMutableArray array];
    for (NSNumber *num in array) {
        NSInteger value = num.integerValue;
        if ([dic.allKeys containsObject:num]) {
            [result addObject:num];
            [result addObject:dic[num]];
            break;
        } else {
            NSInteger offset = target - value;
            [dic setObject:num forKey:@(offset)];
        }
    }
    NSLog(@"%@",result);
}

#pragma mark - 两数相加
- (void)twoNumerAdd:(FCLinkedModel *)link1 link2:(FCLinkedModel *)link2 {
    /**
     [2,4,3]
     [5,6,4]
     [7,0,8]
     */
    FCLinkedModel *result;
    FCLinkedModel *next;
    NSInteger carry = 0;
    while (link1 || link2) {
        NSInteger a_value = 0;
        NSInteger b_value = 0;
        if (link1) {
            a_value = link1.value;
            link1 = link1.nextValue;
        }
        if (link2) {
            b_value = link2.value;
            link2 = link2.nextValue;
        }

        NSInteger value = a_value + b_value + carry;
        NSInteger current_value = 0;
        if (value >= 10) {
            current_value = value%10;
            carry = value/10;
        } else {
            current_value = value;
            carry = 0;
        }
        if (next) {
            next.nextValue = [[FCLinkedModel alloc] init];
            next.nextValue.value = current_value;
            next = next.nextValue;
        } else {
            result = [[FCLinkedModel alloc] init];
            result.value = current_value;
            next = result;
        }
    }

    if (carry > 0) {
        next.nextValue = [[FCLinkedModel alloc] init];
        next.nextValue.value = carry;
    }

    [self printLinkList:result];
}

#pragma mark - 反转链表
- (void)revertLinkList {
    /**
     1->2->3->4->5->nil
     5->4->3->2->1->nil
     */
    FCLinkedModel *link = [self linkedList];
    [self printLinkList:link];

    FCLinkedModel *prev = nil;
    while (link) {
        FCLinkedModel *nextModel = link.nextValue;
        link.nextValue = prev;
        prev = link;
        link = nextModel;
    }
    [self printLinkList:prev];

}

#pragma mark - 两个数组合并有序数组
/// 两个数组合并有序数组
/// @param nums1 第一个数组,长度为m+n
/// @param m 第一个数组的有效个数
/// @param nums2 第二个数组
/// @param n 第二个数组的长度
- (void)mergeTwoArray:(NSMutableArray *)nums1 m:(NSInteger)m nums2:(NSMutableArray *)nums2 n:(NSInteger)n {
    /**
     @[@1,@2,@3,@0,@0,@0]
     3
     @[@2,@5,@6]
     3
     */
    for (NSInteger i = m; i < nums1.count; i++) {
        nums1[i] = nums2[i - m];
    }

    [self quickSort:nums1 left:0 right:nums1.count - 1];
    NSLog(@"%@",nums1);
}

#pragma mark - 判断两个链表是否有交集
/**
 两个链表的第一个公共节点
 */
- (FCLinkedModel *)getIntersectionNode:(FCLinkedModel *)headA headB:(FCLinkedModel *)headB {
    return nil;
}

#pragma mark - z字形打印二叉树
- (void)printBinaryTreeLikeZ {
    FCBinaryTreeModel *tree = [self binaryTreeModel];

}

#pragma mark - 前序输出二叉树
- (void)printBinaryTreeNodeValue:(FCBinaryTreeModel *)node {

}

#pragma mark - 中序输出二叉树
- (void)printBinaryTreeFromMiddleTraversal:(FCBinaryTreeModel *)node {

}

#pragma mark - 后序输出二叉树
- (void)printBinaryTreeFromPostorderTraversal:(FCBinaryTreeModel *)node {

}

#pragma mark - 二叉树的深度
- (NSInteger)binaryDepth:(FCBinaryTreeModel *)node {
    return 0;
}

#pragma mark - 反转二叉树
- (FCBinaryTreeModel *)reversalBinaryTree:(FCBinaryTreeModel *)tree {
    return nil;
}

#pragma mark - 从上向下打印二叉树
//二叉树的层数遍历
- (void)printBinaryTreeFromTopToBottom:(FCBinaryTreeModel *)tree {

}

#pragma mark - 判断一个二叉树是不是平衡二叉树
/**
 输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。
 */
- (void)binaryIsBalanceBianryTree:(FCBinaryTreeModel *)node {

}

#pragma mark - 判断一个二叉树是不是搜索二叉树
/**
 BST树
 假设一个二叉搜索树具有如下特征：
 节点的左子树只包含小于当前节点的数。
 节点的右子树只包含大于当前节点的数。
 所有左子树和右子树自身必须也是二叉搜索树。
 */
- (void)binaryIsSearchBianryTree:(FCBinaryTreeModel *)node {

}

#pragma mark - 从前序与中序遍历序列构造二叉树
- (FCBinaryTreeModel *)buildBinaryFromList:(NSArray *)preorder middle:(NSArray *)inorder {
    return nil;
}

#pragma mark - 判断一个二叉树是不是对称二叉树
- (void)binaryIsSymmetryBianryTree:(FCBinaryTreeModel *)node {

}

#pragma mark - 红黑树


#pragma mark - 无重复字符的最长子串
/**
 滑动窗口
 abcabcbb
*/
- (void)lengthOfLongestSubstring:(NSString *)string {

}

#pragma mark - 斐波拉契数列
/**
 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89
 从第n项开始,第n项的值为f(n)=f(n-1) + f(n-2)
 */
- (NSInteger)fibonacci:(NSInteger)index {
    return 0;
}

#pragma mark - 回文数
/// 时间复杂度：O(logn)
- (void)isPalindromicCount:(NSInteger)count {

}

#pragma mark - 二分查找
//时间复杂度为O(logN)
- (NSInteger)binarySearch:(NSArray *)list target:(NSInteger)target {

    return -1;
}

#pragma mark - 快速排序
/**
 分治法
 1.将大于中间值的数都放到右边
 2.将小于中间值的数都放到左边
 */
- (void)quickSort:(NSMutableArray *)list left:(NSInteger)left right:(NSInteger)right {
    /**
     1,2,3,2,5,6
     */
    if (left >= right) {
        return;
    }

    NSInteger i = left;
    NSInteger j = right;
    NSInteger key_value = [list[i] integerValue];
    while (i < j) {
        //1. 从最后向前查找到第一个小于keyValue的数值
        while (i < j) {
            NSInteger j_value = [self countFromArray:list index:j];
            if (j_value >= key_value) {
                j--;
            } else {
                break;
            }
        }
        if (i == j) {
            break;
        }
        list[i] = list[j];

        while (i < j) {
            NSInteger i_value = [self countFromArray:list index:i];
            if (i_value <= key_value) {
                i++;
            } else {
                break;
            }
        }
        if (i == j) {
            break;
        }
        list[j] = list[i];
    }
    list[i] = @(key_value);
    [self quickSort:list left:left right:i-1];
    [self quickSort:list left:i+1 right:right];
}

#pragma mark - 冒泡排序
- (void)bubbleSort:(NSMutableArray *)list {

}

#pragma mark - 选择排序
- (void)selectSort:(NSMutableArray *)list {

}

#pragma mark - 最长回文子串
- (NSString *)longestPalindrome:(NSString *)s {
    return nil;
}

#pragma mark - 验证是不是回文字符串
- (BOOL)isPalindromeString:(NSString *)s left:(NSInteger)left right:(NSInteger)right {

    return YES;
}

#pragma mark - 寻找两个正序数组的中位数

#pragma mark - 合并两个有序链表
- (FCLinkedModel *)mergeTwoLists:(FCLinkedModel *)l1 l2:(FCLinkedModel *)l2 {
    return nil;
}

#pragma mark - LRU
- (void)LRU {

}

#pragma mark - 盛最多水的容器
- (NSInteger)maxArea:(NSArray *)lineArr {
    return 0;
}


#pragma mark - 二叉搜索树的范围和
- (NSInteger)rangeNumBST:(FCBinaryTreeModel *)node low:(NSInteger)low high:(NSInteger)high {
    return 0;
}

#pragma mark - 顺时针打印矩形
- (void)spiralOrderArray {
    NSArray <NSArray *>*array = @[
        @[@1,@2,@3,@4],
        @[@5,@6,@7,@8],
        @[@9,@10,@11,@12],
    ];


}

#pragma mark - 二叉搜索树的后序遍历结果
- (void)vailedPostorder:(NSArray *)array {

}


#pragma mark - 二叉树中和为某一值的路径
/**
 https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof/solution/mian-shi-ti-34-er-cha-shu-zhong-he-wei-mou-yi-zh-5/
 */
- (NSArray <NSArray *>*)pathSum:(FCBinaryTreeModel *)root target:(NSInteger)target {
    return nil;
}

#pragma mark - 把数组排成最小的数
- (NSString *)minNumber:(NSMutableArray *)nums {
    return 0;
}

#pragma mark - 圆圈中最后剩下的数字
/**
 https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/solution/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-by-lee/
 */

#pragma mark - 数组相关
- (NSInteger)countFromArray:(NSArray *)array index:(NSInteger)index {
    NSNumber *number = array[index];
    return number.integerValue;
}

#pragma mark - 链表数据源
- (FCLinkedModel *)linkedList {
    FCLinkedModel *link1 = [[FCLinkedModel alloc] init];
    FCLinkedModel *link2 = [[FCLinkedModel alloc] init];
    FCLinkedModel *link3 = [[FCLinkedModel alloc] init];
    FCLinkedModel *link4 = [[FCLinkedModel alloc] init];
    FCLinkedModel *link5 = [[FCLinkedModel alloc] init];

    link1.value = 1;
    link2.value = 2;
    link3.value = 3;
    link4.value = 4;
    link5.value = 5;

    link1.nextValue = link2;
    link2.nextValue = link3;
    link3.nextValue = link4;
    link4.nextValue = link5;
    link5.nextValue = nil;

    return link1;
}

- (void)printLinkList:(FCLinkedModel *)list {
    NSString *printStr = [NSString stringWithFormat:@"%@",@(list.value)];
    while (list.nextValue) {
        printStr = [printStr stringByAppendingString:@"->"];
        printStr = [printStr stringByAppendingString:[NSString stringWithFormat:@"%@",@(list.nextValue.value)]];
        list = list.nextValue;
    }
    NSLog(@"链表输出值 %@",printStr);
}

- (FCLinkedModel *)linkedFromArray:(NSArray *)array {
    FCLinkedModel *head = nil;
    FCLinkedModel *next = nil;
    for (NSInteger i = 0; i < array.count; i++) {
        if (!head) {
            head = [[FCLinkedModel alloc] init];
            next = head;
        }
        next.value = [self countFromArray:array index:i];
        if (i != array.count - 1) {
            FCLinkedModel *nextValue = [[FCLinkedModel alloc] init];
            next.nextValue = nextValue;
            next = nextValue;
        }
    }
    return head;
}

#pragma mark - 二叉树数据源
- (FCBinaryTreeModel *)binaryTreeModel {
    FCBinaryTreeModel *root = [self rootBinaryTreeNode:1 leftValue:2 rightValue:3];
    [self subBinaryTreeNode:root.leftNode leftValue:4 rightValue:5];
    [self subBinaryTreeNode:root.rightNode leftValue:6 rightValue:7];
    [self subBinaryTreeNode:root.leftNode.rightNode leftValue:8 rightValue:9];
    [self subBinaryTreeNode:root.leftNode.rightNode.leftNode leftValue:10 rightValue:11];
    return root;
}

//对称二叉树
- (FCBinaryTreeModel *)symmetryBinaryTreeModel {
    FCBinaryTreeModel *root = [self rootBinaryTreeNode:1 leftValue:2 rightValue:2];
    [self subBinaryTreeNode:root.leftNode leftValue:3 rightValue:4];
    [self subBinaryTreeNode:root.rightNode leftValue:4 rightValue:3];
    [self subBinaryTreeNode:root.leftNode.leftNode leftValue:6 rightValue:5];
    [self subBinaryTreeNode:root.rightNode.rightNode leftValue:5 rightValue:6];
    return root;
}

//搜索二叉树
- (FCBinaryTreeModel *)searchBinaryTree {
    FCBinaryTreeModel *node = [self rootBinaryTreeNode:4 leftValue:2 rightValue:5];
    [self subBinaryTreeNode:node.leftNode leftValue:1 rightValue:3];
    [self subBinaryTreeNode:node.rightNode leftValue:-1 rightValue:6];
    return node;
}

/// 创建二叉树根节点
- (FCBinaryTreeModel *)rootBinaryTreeNode:(NSInteger)rootValue leftValue:(NSInteger)leftValue rightValue:(NSInteger)rightValue {
    //左节点
    FCBinaryTreeModel *leftNode = [[FCBinaryTreeModel alloc] init];
    leftNode.value = leftValue;
    //右节点
    FCBinaryTreeModel *rightNode = [[FCBinaryTreeModel alloc] init];
    rightNode.value = rightValue;
    //根节点
    FCBinaryTreeModel *rootNode = [[FCBinaryTreeModel alloc] init];
    rootNode.value = rootValue;
    rootNode.leftNode = leftNode;
    rootNode.rightNode = rightNode;
    return rootNode;
}

/// 绑定二叉树值
- (void)subBinaryTreeNode:(FCBinaryTreeModel *)rootNode leftValue:(NSInteger)leftValue rightValue:(NSInteger)rightValue {
    //左节点
    FCBinaryTreeModel *leftNode = [[FCBinaryTreeModel alloc] init];
    leftNode.value = leftValue;
    //右节点
    FCBinaryTreeModel *rightNode = [[FCBinaryTreeModel alloc] init];
    rightNode.value = rightValue;
    //根节点
    if (leftNode.value > 0) {
        rootNode.leftNode = leftNode;
    }
    if (rightNode.value > 0) {
        rootNode.rightNode = rightNode;
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_identifier"];
    }
    cell.textLabel.text = self.tableListArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *list = @[@0,@1,@3,@4,@6,@8];
    NSArray *randomList = @[@7,@5,@2,@9,@6,@8,@7,@999];

    NSString *title = self.tableListArray[indexPath.row];
    if ([title isEqualToString:@"二分查找"]) {
        NSInteger target = 3;
        NSInteger index = [self binarySearch:list target:target];
        NSLog(@"二分查找 %@",@(index));
    } else if ([title isEqualToString:@"快速排序"]) {
        [self quickSort:[randomList mutableCopy] left:0 right:randomList.count - 1];
    } else if ([title isEqualToString:@"冒泡排序"]) {
        [self bubbleSort:[randomList mutableCopy]];
    } else if ([title isEqualToString:@"选择排序"]) {
        [self selectSort:[randomList mutableCopy]];
    } else if ([title isEqualToString:@"回文数"]) {
        [self isPalindromicCount:1001001];
    } else if ([title isEqualToString:@"反转链表"]) {
        [self revertLinkList];
    } else if ([title isEqualToString:@"z字形打印二叉树"]) {
        [self printBinaryTreeLikeZ];
    } else if ([title isEqualToString:@"反转二叉树"]) {
        FCBinaryTreeModel *treeNode = [self reversalBinaryTree:[self binaryTreeModel]];
        [self printBinaryTreeNodeValue:treeNode];
    } else if ([title isEqualToString:@"从上向下打印二叉树"]) {
        [self printBinaryTreeFromTopToBottom:[self binaryTreeModel]];
    } else if ([title isEqualToString:@"判断一个二叉树是不是平衡二叉树"]) {
        [self binaryIsBalanceBianryTree:[self binaryTreeModel]];
    } else if ([title isEqualToString:@"前序输出二叉树"]) {
        [self printBinaryTreeNodeValue:[self symmetryBinaryTreeModel]];
    } else if ([title isEqualToString:@"中序输出二叉树"]) {
        [self printBinaryTreeFromMiddleTraversal:[self symmetryBinaryTreeModel]];
    } else if ([title isEqualToString:@"后序输出二叉树"]) {
        [self printBinaryTreeFromPostorderTraversal:[self symmetryBinaryTreeModel]];
    } else if ([title isEqualToString:@"二叉树的深度"]) {
        NSInteger line = [self binaryDepth:[self binaryTreeModel]];
        NSLog(@"二叉树的深度 %@",@(line));
    } else if ([title isEqualToString:@"判断一个二叉树是不是搜索二叉树"]) {
        [self binaryIsSearchBianryTree:[self searchBinaryTree]];
    } else if ([title isEqualToString:@"判断一个二叉树是不是对称二叉树"]) {
        [self binaryIsSymmetryBianryTree:[self symmetryBinaryTreeModel]];
    } else if ([title isEqualToString:@"从前序与中序遍历序列构造二叉树"]) {
        [self buildBinaryFromList:@[@3,@9,@20,@15,@7] middle:@[@9,@3,@15,@20,@7]];
    } else if ([title isEqualToString:@"两数之和"]) {
        [self twoNumber:9 array:@[@1,@2,@3,@7,@11,@15]];
    } else if ([title isEqualToString:@"两数相加"]) {
        //2,6,3
        //5,6,4
        FCLinkedModel *link1_1 = [[FCLinkedModel alloc] init];
        link1_1.value = 2;
        FCLinkedModel *link1_2 = [[FCLinkedModel alloc] init];
        link1_2.value = 4;
        link1_1.nextValue = link1_2;
        FCLinkedModel *link1_3 = [[FCLinkedModel alloc] init];
        link1_3.value = 3;
        link1_2.nextValue = link1_3;

        FCLinkedModel *link2_1 = [[FCLinkedModel alloc] init];
        link2_1.value = 5;
        FCLinkedModel *link2_2 = [[FCLinkedModel alloc] init];
        link2_2.value = 6;
        link2_1.nextValue = link2_2;
        FCLinkedModel *link2_3 = [[FCLinkedModel alloc] init];
        link2_3.value = 4;
        link2_2.nextValue = link2_3;

        [self twoNumerAdd:link1_1 link2:link2_1];
    } else if ([title isEqualToString:@"无重复字符的最长子串"]) {
        [self lengthOfLongestSubstring:@"abcabcbb"];
    } else if ([title isEqualToString:@"斐波拉契数列"]) {
        NSInteger result = [self fibonacci:10];
        NSLog(@"%@",@(result));
    } else if ([title isEqualToString:@"两个数组合并有序数组"]) {
        [self mergeTwoArray:[@[@1,@2,@3,@0,@0,@0] mutableCopy] m:3 nums2:[@[@2,@5,@6] mutableCopy] n:3];
    } else if ([title isEqualToString:@"判断两个链表是否有交集"]) {
        FCLinkedModel *node_general = [self linkedFromArray:@[@8,@4,@5]];
        FCLinkedModel *nodeA = [self linkedFromArray:@[@4,@1]];
        FCLinkedModel *tempA = nodeA;
        while (tempA.nextValue) {
            tempA = tempA.nextValue;
        }
        tempA.nextValue = node_general;
        FCLinkedModel *nodeB = [self linkedFromArray:@[@5,@0,@1]];
        FCLinkedModel *tempB = nodeB;
        while (tempB.nextValue) {
            tempB = tempB.nextValue;
        }
        tempB.nextValue = node_general;
        [self getIntersectionNode:nodeA headB:nodeB];
    } else if ([title isEqualToString:@"最长回文子串"]) {
        [self longestPalindrome:@"babab"];
    } else if ([title isEqualToString:@"找两个正序数组的中位数"]) {

    } else if ([title isEqualToString:@"合并两个有序链表"]) {
        FCLinkedModel *merge_Link = [self mergeTwoLists:[self linkedFromArray:@[@1,@2,@4]] l2:[self linkedFromArray:@[@1,@3,@4]]];
        [self printLinkList:merge_Link];
    } else if ([title isEqualToString:@"LRU"]) {
        [self LRU];
    } else if ([title isEqualToString:@"盛最多水的容器"]) {
        [self maxArea:@[@1, @8, @6, @2, @5, @4, @8, @3, @7]];
    } else if ([title isEqualToString:@"二叉搜索树的范围和"]) {
        FCBinaryTreeModel *root = [self rootBinaryTreeNode:10 leftValue:5 rightValue:15];
        [self subBinaryTreeNode:root.leftNode leftValue:3 rightValue:7];
        [self subBinaryTreeNode:root.rightNode leftValue:-1 rightValue:18];
        NSInteger value = [self rangeNumBST:root low:7 high:15];
        NSLog(@"%@",@(value));
    } else if ([title isEqualToString:@"顺时针打印矩形"]) {
        [self spiralOrderArray];
    } else if ([title isEqualToString:@"二叉搜索树的后序遍历结果"]) {
        [self vailedPostorder:@[@1,@3,@2,@7,@8,@6,@5]];
    } else if ([title isEqualToString:@"二叉树中和为某一值的路径"]) {
        FCBinaryTreeModel *root = [self buildBinaryFromList:@[@5,@4,@11,@7,@2,@8,@13,@3,@6,@1] middle:@[@7,@11,@2,@4,@5,@13,@8,@6,@3,@1]];
        NSLog(@">>>>>>>");
        [self pathSum:root target:22];
    } else if ([title isEqualToString:@"把数组排成最小的数"]) {
        NSArray *nums = @[@3,@30,@34,@5,@9];
        [self minNumber:[NSMutableArray arrayWithArray:nums]];
    } else {
        NSLog(@"点击事件未实现");
    }
}

#pragma mark - lazy
- (NSArray *)tableListArray {

    if (!_tableListArray) {
        _tableListArray = @[
            @"把数组排成最小的数",
            @"二叉树中和为某一值的路径",
            @"二叉搜索树的后序遍历结果",
            @"顺时针打印矩形",
            @"二叉搜索树的范围和",
            @"盛最多水的容器",
            @"LRU",
            @"合并两个有序链表",
            @"验证是不是回文字符串",
            @"最长回文子串",
            @"寻找两个正序数组的中位数",
            @"两数之和",
            @"两数相加",
            @"反转链表",
            @"两个数组合并有序数组",
            @"判断两个链表是否有交集",
            @"z字形打印二叉树",
            @"反转二叉树",
            @"从上向下打印二叉树",
            @"判断一个二叉树是不是平衡二叉树",
            @"判断一个二叉树是不是搜索二叉树",
            @"判断一个二叉树是不是对称二叉树",
            @"前序输出二叉树",
            @"中序输出二叉树",
            @"后序输出二叉树",
            @"从前序与中序遍历序列构造二叉树",
            @"二叉树的深度",
            @"无重复字符的最长子串",
            @"斐波拉契数列",
            @"回文数",
            @"二分查找",
            @"快速排序",
            @"冒泡排序",
            @"选择排序"
        ];
    }
    return _tableListArray;
}

@end
