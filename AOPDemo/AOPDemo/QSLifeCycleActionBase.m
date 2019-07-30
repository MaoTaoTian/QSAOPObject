//
//  QSLifeCycleActionBase.m
//  TestDemo
//
//  Created by 哔哩哔哩 on 2019/7/30.
//  Copyright © 2019 tianmaotao. All rights reserved.
//

#import "QSLifeCycleActionBase.h"

@implementation QSLifeCycleActionBase

- (void)hostViewDidLoadController:(UIViewController *)vc {
    // 通用逻辑处理
}

- (void)hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated {
    // 通用逻辑处理
}

- (void)hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated {
    // 通用逻辑处理
}

- (void)hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated {
    // 通用逻辑处理
}

- (void)hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated {
    // 通用逻辑处理
}

@end
