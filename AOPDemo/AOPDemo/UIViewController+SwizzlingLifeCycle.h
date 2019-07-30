//
//  UIViewController+SwizzlingLifeCycle.h
//  TestDemo
//
//  Created by 哔哩哔哩 on 2019/7/30.
//  Copyright © 2019 tianmaotao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QSLifeCycleActionBase;
@interface UIViewController (SwizzlingLifeCycle)

- (BOOL)registerLifeCycleAction:(QSLifeCycleActionBase *)lifeCycleAction;
- (BOOL)removeLifeCycleAction:(QSLifeCycleActionBase *)lifeCycleAction;
- (void)removeAllAction;

@end

NS_ASSUME_NONNULL_END
