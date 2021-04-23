//
//  ViewController.m
//  LeetCode
//
//  Created by fanchuan on 2021/4/20.
//

#import "ViewController.h"
#import "FCLinkedModel.h"
#import "FCBinaryTreeModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *tableListArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 两数之和
//时间复杂度：O(N)
- (void)twoNumber:(NSInteger)target array:(NSArray *)array {
    //采用hashtable的特效,key的唯一性
    NSMutableArray *reslut = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger count = [self countFromArray:array index:i];
        if ([dic.allKeys containsObject:@(count)]) {
            [reslut addObject:[dic objectForKey:@(count)]];
            [reslut addObject:@(count)];
            break;
        } else {
            //需要匹配的数字
            NSInteger offset = target - count;
            [dic setObject:@(count) forKey:@(offset)];
        }
    }
    NSLog(@"%@",reslut);
}

#pragma mark - 两数相加
- (void)twoNumerAdd:(FCLinkedModel *)link1 link2:(FCLinkedModel *)link2 {
/**
 [2,4,3]
 [5,6,4]
 [7,0,8]
 解释：342 + 465 = 807.
 */
    FCLinkedModel *result_head;
    FCLinkedModel *result_tail;
    NSInteger carry = 0;
    while (link1 || link2) {
        NSInteger one = 0;
        NSInteger two = 0;
        if (link1) {
            one = link1.value;
        }
        if (link2) {
            two = link2.value;
        }
        NSInteger number = one + two + carry;
        NSInteger value = 0;
        if (number >= 10) {
            value = number%10;
            carry = number/10;
        } else {
            value = number;
            carry = 0;
        }

        if (!result_head) {
            FCLinkedModel *model = [[FCLinkedModel alloc] init];
            result_head = model;
            result_tail = result_head;
            model.value = value;
        } else {
            result_tail.nextValue = [[FCLinkedModel alloc] init];
            result_tail.nextValue.value = value;
            result_tail = result_tail.nextValue;
        }

        if (link1) {
            link1 = link1.nextValue;
        }
        if (link2) {
            link2 = link2.nextValue;
        }
    }
    if (carry > 0) {
        result_tail.nextValue = [[FCLinkedModel alloc] init];
        result_tail.nextValue.value = carry;
    }
    [self printLinkList:result_head];
}

#pragma mark - 反转链表
- (void)revertLinkList {
    FCLinkedModel *list = [self linkedList];

    //迭代实现
    /**
     时间复杂度 O(n)
     空间复杂度 0(1)
     */
    FCLinkedModel *prev = nil;
    while (list) {
        FCLinkedModel *nextModel = list.nextValue;
        list.nextValue = prev;
        prev = list;
        list = nextModel;
    }
    [self printLinkList:prev];
}

#pragma mark - 两个数组合并有序数组

#pragma mark - 判断两个链表是否有交集

#pragma mark - z字形打印二叉树
- (void)printBinaryTreeLikeZ {
    FCBinaryTreeModel *tree = [self binaryTreeModel];
    NSInteger currntLine = 0;
    //偶数数组
    NSMutableArray *evenArr = [NSMutableArray array];
    //奇数数组
    NSMutableArray *oddArr = [NSMutableArray array];
    [evenArr addObject:tree];

    while (evenArr.count > 0 || oddArr.count > 0) {
        if (currntLine%2 == 0) {
            [evenArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(FCBinaryTreeModel  *node, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",@(node.value));
                if (node.leftNode) {
                    [oddArr addObject:node.leftNode];
                }
                if (node.rightNode) {
                    [oddArr addObject:node.rightNode];
                }
            }];
            [evenArr removeAllObjects];
        } else {
            //奇数行
            [oddArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(FCBinaryTreeModel  *node, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",@(node.value));
                if (node.rightNode) {
                    [evenArr addObject:node.rightNode];
                }
                if (node.leftNode) {
                    [evenArr addObject:node.leftNode];
                }
            }];
            [oddArr removeAllObjects];
        }
        currntLine++;
    }
}

#pragma mark - 前序输出二叉树
- (void)printBinaryTreeNodeValue:(FCBinaryTreeModel *)node {
    NSLog(@"%@",@(node.value));
    if (node.leftNode || node.rightNode) {
        if (node.leftNode) {
            [self printBinaryTreeNodeValue:node.leftNode];
        }

        if (node.rightNode) {
            [self printBinaryTreeNodeValue:node.rightNode];
        }
    }
}

#pragma mark - 中序输出二叉树
- (void)printBinaryTreeFromMiddleTraversal:(FCBinaryTreeModel *)node {
    //左根右
    if (!node) {
        return;
    }
    [self printBinaryTreeFromMiddleTraversal:node.leftNode];
    NSLog(@"%@",@(node.value));
    [self printBinaryTreeFromMiddleTraversal:node.rightNode];
}

#pragma mark - 后序输出二叉树
- (void)printBinaryTreeFromPostorderTraversal:(FCBinaryTreeModel *)node {
    if (!node) {
        return;
    }
    [self printBinaryTreeFromPostorderTraversal:node.leftNode];
    [self printBinaryTreeFromPostorderTraversal:node.rightNode];
    NSLog(@"%@",@(node.value));
}

#pragma mark - 二叉树的深度
- (NSInteger)binaryDepth:(FCBinaryTreeModel *)node {
    if (!node) {
        return 0;
    }
    NSInteger left = [self binaryDepth:node.leftNode];
    NSInteger right = [self binaryDepth:node.rightNode];
    return MAX(left, right) + 1;
}

#pragma mark - 反转二叉树
- (FCBinaryTreeModel *)reversalBinaryTree:(FCBinaryTreeModel *)tree {
    if (tree.leftNode || tree.rightNode) {
        FCBinaryTreeModel *leftNode = [self reversalBinaryTree:tree.leftNode];
        FCBinaryTreeModel *rightNode = [self reversalBinaryTree:tree.rightNode];
        tree.leftNode = rightNode;
        tree.rightNode = leftNode;
    }
    return tree;
}

#pragma mark - 从上向下打印二叉树
//二叉树的层数遍历
- (void)printBinaryTreeFromTopToBottom:(FCBinaryTreeModel *)tree {
    NSMutableArray *listArray = [NSMutableArray array];
    [listArray addObject:tree];
    while (listArray.count > 0) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (FCBinaryTreeModel *node in listArray) {
            NSLog(@"%@",@(node.value));
            if (node.leftNode) {
                [tempArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [tempArray addObject:node.rightNode];
            }
        }
        [listArray removeAllObjects];
        [listArray addObjectsFromArray:tempArray];
    }
}

#pragma mark - 判断一个二叉树是不是平衡二叉树
/**
 输入一棵二叉树的根节点，判断该树是不是平衡二叉树。如果某二叉树中任意节点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。
 */
- (void)binaryIsBalanceBianryTree:(FCBinaryTreeModel *)node {
    if ([self recur:node] != -1) {
        NSLog(@"是平衡二叉树");
    } else {
        NSLog(@"不是平衡二叉树");
    }
}

- (NSInteger)recur:(FCBinaryTreeModel *)node {
    if (!node) {
        return 0;
    }
    NSInteger left = [self recur:node.leftNode];
    if (left == -1) {
        return -1;
    }
    NSInteger right = [self recur:node.rightNode];
    if (right == -1) {
        return -1;
    }
    if (labs(left - right) < 2) {
        return MAX(left, right) + 1;
    } else {
        return -1;
    }
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
//    BOOL isSearchBinary = [self isSearchBinary:node minValue:INT64_MIN maxValue:INT64_MAX];
    BOOL isSearchBinary = [self isBSTTreeFormMiddleTraversal:node];
    NSLog(@"是不是搜索二叉树 %@",@(isSearchBinary));
}

- (BOOL)isSearchBinary:(FCBinaryTreeModel *)node minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue {
    if (!node) {
        return YES;
    }
    if (node.value <= minValue || node.value >= maxValue) {
        return NO;
    }
    return [self isSearchBinary:node.leftNode minValue:minValue maxValue:node.value] && [self isSearchBinary:node.rightNode minValue:node.value maxValue:maxValue];
}

/**
 判断是不是搜索二叉树,采用中序遍历方法,满足进栈后从小到大的线性列表
 https://leetcode-cn.com/problems/validate-binary-search-tree/solution/yan-zheng-er-cha-sou-suo-shu-by-leetcode-solution/
 */
- (BOOL)isBSTTreeFormMiddleTraversal:(FCBinaryTreeModel *)node {
    NSMutableArray *stack = [NSMutableArray array];
    NSInteger inorder = -1;
    while (stack.count > 0 || node) {
        while (node) {
            [stack addObject:node];
            node = node.leftNode;
        }

        node = stack.lastObject;
        [stack removeLastObject];
        if (node.value <= inorder) {
            return NO;
        }
        inorder = node.value;
        node = node.rightNode;
    }
    return YES;
}

#pragma mark - 从前序与中序遍历序列构造二叉树
- (void)buildBinaryFromList:(NSArray *)preorder middle:(NSArray *)inorder {
    NSInteger n = preorder.count;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < inorder.count; i++) {
        [dic setObject:@(i) forKey:inorder[i]];
    }
    FCBinaryTreeModel *node = [self buildTree:preorder inorder:inorder preLeft:0 preRight:n-1 inorderLeft:0 inorderRight:n-1 map:dic];
    /**
     preorder [@3,@9,@20,@15,@7]
     inorder [@9,@3,@15,@20,@7]
     */
    [self printBinaryTreeNodeValue:node];
    NSLog(@">>>>>");
    [self printBinaryTreeFromMiddleTraversal:node];
}

- (FCBinaryTreeModel *)buildTree:(NSArray *)preorder
                         inorder:(NSArray *)inordere
                         preLeft:(NSInteger)preLeft
                        preRight:(NSInteger)preRight
                     inorderLeft:(NSInteger)inorderLeft
                    inorderRight:(NSInteger)inorderRight map:(NSDictionary *)dic {
    if (preLeft > preRight) {
        return nil;
    }

    NSInteger pre_root = preLeft;
    //获取当前根节点在中序遍历中的下标
    NSInteger inorder_root = [[dic objectForKey:preorder[pre_root]] integerValue];

    FCBinaryTreeModel *root = [[FCBinaryTreeModel alloc] init];
    root.value = [preorder[pre_root] integerValue];
    // 得到左子树中的节点数目
    NSInteger size_left_subtree = inorder_root - inorderLeft;
    // 递归左树
    root.leftNode = [self buildTree:preorder inorder:inordere preLeft:preLeft+1 preRight:preLeft+1+size_left_subtree inorderLeft:inorderLeft inorderRight:inorder_root-1 map:dic];
    // 递归右树
    root.rightNode = [self buildTree:preorder inorder:inordere preLeft:preLeft+1+size_left_subtree+1 preRight:preRight inorderLeft:inorder_root+1 inorderRight:inorderRight map:dic];
    return root;
}

#pragma mark - 判断一个二叉树是不是对称二叉树
- (void)binaryIsSymmetryBianryTree:(FCBinaryTreeModel *)node {
    //采用队列方法,二者数据相同时为对称二叉树
//    [self binaryIsSymmetryBianryTree_A:node];

    BOOL is = [self checkIsSymmetryBianryTree:node rightNode:node];
    if (is) {
        NSLog(@"是对称二叉树");
    } else {
        NSLog(@"不是对称二叉树");
    }
}

//平衡二叉树最优解,时间复杂度O(n)
- (BOOL)checkIsSymmetryBianryTree:(FCBinaryTreeModel *)leftNode rightNode:(FCBinaryTreeModel *)rightNode {
    if (!leftNode && !rightNode) {
        return YES;
    } else if (!leftNode || !rightNode) {
        return NO;
    } else {
        if (leftNode.value == rightNode.value &&
            [self checkIsSymmetryBianryTree:leftNode.leftNode rightNode:rightNode.rightNode] &&
            [self checkIsSymmetryBianryTree:leftNode.rightNode rightNode:rightNode.leftNode]) {
            return YES;
        } else {
            return NO;
        }
    }
}

//队列形式对称二叉树
- (void)binaryIsSymmetryBianryTree_A:(FCBinaryTreeModel *)node {
    NSMutableArray *left = [NSMutableArray array];
    [left addObject:node.leftNode];
    [self currentLeftTree:node.leftNode arr:left];

    NSMutableArray *right = [NSMutableArray array];
    [right addObject:node.rightNode];
    [self currentRightTree:node.rightNode arr:right];
    BOOL is = NO;
    NSInteger repetCount = 0;
    if (left.count == right.count) {
        for (NSInteger i = 0; i < left.count; i++) {
            FCBinaryTreeModel *left_node = left[i];
            FCBinaryTreeModel *right_node = right[i];
            if (left_node.value == right_node.value) {
                repetCount++;
            } else {
                is = NO;
                break;
            }
        }
        if (repetCount == left.count) {
            is = YES;
        }
    }

    if (is) {
        NSLog(@"是对称二叉树");
    } else {
        NSLog(@"不是对称二叉树");
    }
}

- (void)currentLeftTree:(FCBinaryTreeModel *)node arr:(NSMutableArray *)arr {
    if (node.leftNode || node.rightNode) {
        if (node.leftNode) {
            [arr addObject:node.leftNode];
        }
        [self currentLeftTree:node.leftNode arr:arr];

        if (node.rightNode) {
            [arr addObject:node.rightNode];
        }
        [self currentLeftTree:node.rightNode arr:arr];
    }
}

- (void)currentRightTree:(FCBinaryTreeModel *)node arr:(NSMutableArray *)arr {
    if (node.leftNode || node.rightNode) {
        if (node.rightNode) {
            [arr addObject:node.rightNode];
        }
        [self currentRightTree:node.rightNode arr:arr];

        if (node.leftNode) {
            [arr addObject:node.leftNode];
        }
        [self currentRightTree:node.leftNode arr:arr];
    }
}

#pragma mark - 无重复字符的最长子串

#pragma mark - 回文数
/// 时间复杂度：O(logn)
- (void)isPalindromicCount:(NSInteger)count {
    BOOL is = NO;
    NSInteger printValue = count;
    if (count <= 10) {
        is = NO;
    } else {
        NSInteger revertedNum = 0;
        while (count > revertedNum) {
            revertedNum = revertedNum*10 + count%10;
            count = count / 10;
        }
        if (count == revertedNum || count == revertedNum/10) {
            is = YES;
        }
    }
    NSLog(@"%@ 是不是回文数 %@",@(printValue),@(is));
}

#pragma mark - 二分查找
//时间复杂度为O(logN)
- (NSInteger)binarySearch:(NSArray *)list target:(NSInteger)target {
    NSInteger left = 0;
    NSInteger right = list.count - 1;
    while (left <= right) {
        NSInteger middle = (left + right) / 2;
        NSInteger middleValue = [self countFromArray:list index:middle];
        if (middleValue > target) {
            right = middle - 1;
        } else if (middleValue < target) {
            left = middle + 1;
        } else {
            return middle;
        }
    }
    return -1;
}

#pragma mark - 快速排序
/**
 分治法
 1.将大于中间值的数都放到右边
 2.将小于中间值的数都放到左边
 */
- (void)quickSort:(NSMutableArray *)list left:(NSInteger)left right:(NSInteger)right {
    if (left >= right) {
        //当左侧索引 >= 右侧索引时,说明遍历完成
        NSLog(@"快速排序 %@",list);
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    NSInteger key_value = [self countFromArray:list index:i];
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
            //说明选择的起始数值已经是最小的数了
            break;
        }
        list[i] = list[j];

        //1. 从最前向后查找到第一个大于keyValue的数值
        while (i < j) {
            NSInteger i_value = [self countFromArray:list index:i];
            if (i_value <= key_value) {
                i++;
            } else {
                break;
            }
        }
        if (i == j) {
            //说明选择的起始数值已经是最小的数了
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
    for (NSInteger i = 0; i < list.count; i++) {
        for (NSInteger j = i+1; j < list.count; j++) {
            NSInteger i_value = [self countFromArray:list index:i];
            NSInteger j_value = [self countFromArray:list index:j];
            if (i_value > j_value) {
                list[j] = @(i_value);
                list[i] = @(j_value);
            }
        }
    }
    NSLog(@"冒泡排序 %@",list);
}

#pragma mark - 选择排序
- (void)selectSort:(NSMutableArray *)list {
    for (NSInteger i = 0; i < list.count; i++) {
        NSInteger i_value = [self countFromArray:list index:i];
        for (NSInteger j = i+1; j < list.count; j++) {
            NSInteger j_value = [self countFromArray:list index:j];
            if (j_value < i_value) {
                list[j] = @(i_value);
                i_value = j_value;
            }
        }
        list[i] = @(i_value);
    }
    NSLog(@"选择排序 %@",list);
}

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
    } else {
        NSLog(@"点击事件未实现");
    }
}

#pragma mark - lazy
- (NSArray *)tableListArray {

    if (!_tableListArray) {
        _tableListArray = @[
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
