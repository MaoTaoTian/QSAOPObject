//
//  QSLifeCycleActionBase.h
//  TestDemo
//
//  Created by 哔哩哔哩 on 2019/7/30.
//  Copyright © 2019 tianmaotao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSLifeCycleActionBase : NSObject

@property  (nonatomic, weak, readonly) UIViewController *viewController;
@property (nonatomic, strong) NSString *identifier;

- (void)hostViewDidLoadController:(UIViewController *)vc;
- (void)hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated;
- (void)hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated;
- (void)hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated;
- (void)hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
