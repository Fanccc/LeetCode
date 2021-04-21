//
//  ViewController.m
//  LeetCode
//
//  Created by fanchuan on 2021/4/20.
//

#import "ViewController.h"
#import "FCLinkedModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //二分查找,用于有序的队列
    NSArray *list = @[@0,@1,@3,@4,@6,@8];
    NSInteger target = 3;
    NSInteger index = [self binarySearch:list target:target];
    NSLog(@"二分查找 %@",@(index));

    NSArray *randomList = @[@7,@5,@2,@9,@6,@8,@7,@999];
    //快排
    [self quickSort:[randomList mutableCopy] left:0 right:randomList.count - 1];
    //冒泡
    [self bubbleSort:[randomList mutableCopy]];
    //选择排序
    [self selectSort:[randomList mutableCopy]];
    //回文串
    [self isPalindromicCount:1001001];

    //反转链表
    [self revertLinkList];
}

#pragma mark - 反转链表
- (void)revertLinkList {
    NSArray *list = [self linkedListArray];
    [self printLinkList:list];
}

#pragma mark - 两个数组合并有序数组

#pragma mark - 判断两个链表是否有交集

#pragma mark - z字形打印二叉树

#pragma mark - 判断一个二叉树是不是平衡二叉树（不适用递归）

#pragma mark - 判断一个二叉树是不是搜索二叉树

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

#pragma mark - Private
- (NSInteger)countFromArray:(NSArray *)array index:(NSInteger)index {
    NSNumber *number = array[index];
    return number.integerValue;
}

- (NSArray *)linkedListArray {
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

    return @[link1,link2,link5,link4,link5];
}

- (void)printLinkList:(NSArray *)list {
    NSString *printStr = @"";
    for (FCLinkedModel *model in list) {
        if (printStr.length > 0) {
            printStr = [printStr stringByAppendingString:@"->"];
        }
        printStr = [printStr stringByAppendingString:[NSString stringWithFormat:@"%@",@(model.value)]];
    }
    NSLog(@"链表输出值 %@",printStr);
}

@end
