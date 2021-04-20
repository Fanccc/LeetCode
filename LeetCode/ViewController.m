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

}

#pragma mark - 二分查找
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



#pragma mark - Private
- (NSInteger)countFromArray:(NSArray *)array index:(NSInteger)index {
    NSNumber *number = array[index];
    return number.integerValue;
}

@end
