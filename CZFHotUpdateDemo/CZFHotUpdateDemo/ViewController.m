//
//  ViewController.m
//  CZFHotUpdateDemo
//
//  Created by 陈帆 on 2019/11/9.
//  Copyright © 2019 陈帆. All rights reserved.
//

#import "ViewController.h"
#import <CZFHotUpdate/CZFHotUpdate.h>

@interface ViewController ()

@property(nonatomic, copy) NSString *libPath;
@property(nonatomic, weak) NSBundle *libBundle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"主页面";
    
    // 由于在iOS10之后的系统已经禁止将动态库放在沙盒中加载，如果需要使用热更新，此方法则不可用
    // 目前只能模拟器测试, 必须放在library的目录中
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    libPath = [libPath stringByAppendingPathComponent:@"CZFHotUpdate.framework"];
    self.libPath = libPath;
}

- (IBAction)pushVcClick:(id)sender {
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:self.libPath];
    if (!exists) {
        [self showAlertViewWithTitle:@"提示" Message:@"动态库不存在"];
        return;
    }
    
    // 动态库生成 bundle
    NSBundle *libBundle = [NSBundle bundleWithPath:self.libPath];
    if (!libBundle) {
        [self showAlertViewWithTitle:@"提示" Message:@"生成bundle失败"];
        return;
    }
    self.libBundle = libBundle;
    
    // 加载bundle
    if (![libBundle load]) {
        NSLog(@"bundle load failed");
    }
    
    // 创建bundle中的共有类
    Class class = [libBundle classNamed:@"ColosViewController"];
    if (!class) {
        [self showAlertViewWithTitle:@"提示" Message:@"加载动态库中的类失败"];
//        [self jumpToVc];
        return;
    }
    
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}


-(void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:true completion:nil];
}


- (void)jumpToVc {
    ColosViewController *vc = [[ColosViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
