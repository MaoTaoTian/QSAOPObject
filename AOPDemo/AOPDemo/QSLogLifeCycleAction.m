//
//  QSLogLifeCycleAction.m
//  TestDemo
//
//  Created by 哔哩哔哩 on 2019/7/30.
//  Copyright © 2019 tianmaotao. All rights reserved.
//

#import "QSLogLifeCycleAction.h"

@implementation QSLogLifeCycleAction

- (void)hostViewDidLoadController:(UIViewController *)vc {
    NSLog(@"hostViewDidLoadController");
}

- (void)hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated {
    NSLog(@"hostController viewWillAppear");
}

- (void)hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated {
    NSLog(@"hostController viewDidAppear");
}

- (void)hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated {
    NSLog(@"hostController viewWillDisappear");
}

- (void)hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated {
    NSLog(@"hostController viewDidDisappear");
}

@end
