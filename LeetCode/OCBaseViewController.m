//
//  OCBaseViewController.m
//  LeetCode
//
//  Created by fanchuan on 2021/4/26.
//

#import "OCBaseViewController.h"
#import <objc/runtime.h>

@interface OCBaseViewController ()

@property (nonatomic, strong) UIView *subView;

@end

@implementation OCBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.subView = [[UIView alloc] init];



}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self aaa:self.subView];

    dispatch_queue_t queue = dispatch_queue_create("qaq", DISPATCH_QUEUE_SERIAL);

    __block int a = 0;
    while (a < 5) {
        dispatch_sync(queue, ^{
            a++;
//            NSLog(@"11111");
        });
    }
    NSLog(@"%d",a);  //输出结果是>=5的

}

- (void)aaa:(UIView *)view {

    __block NSString *a = @"0";
    void (^foo)(void) = ^ {
        a = @"1";
        NSLog(@"%@ %p",a,&a);
    };

    NSLog(@"%@ %p",a,&a);
    foo();
    NSLog(@"%@ %p",a,&a);

// 内存地址 & 指针地址
//    NSLog(@"%p",&view);
//    UIView *v = self.subView;
//    NSLog(@"%p",&v);

//    __weak typeof(self) weakSelf = self;
//    __strong typeof(weakSelf) strongSelf = weakSelf;

}


@end
