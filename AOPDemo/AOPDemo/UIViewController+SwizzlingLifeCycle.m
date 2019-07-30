//
//  UIViewController+SwizzlingLifeCycle.m
//  TestDemo
//
//  Created by 哔哩哔哩 on 2019/7/30.
//  Copyright © 2019 tianmaotao. All rights reserved.
//

#import "UIViewController+SwizzlingLifeCycle.h"
#import "QSLifeCycleActionBase.h"
#import <objc/runtime.h>

static void* QSLifeCycleKey = &QSLifeCycleKey;
typedef void(^QSActionBlock)(QSLifeCycleActionBase* action);

void QS_swizzlingInstanceMethod(Class class, SEL orginSel, SEL swizzlingSel)
{
    Method method1 = class_getInstanceMethod(class, orginSel);
    Method method2 = class_getInstanceMethod(class, swizzlingSel);
    method_exchangeImplementations(method1, method2);
}

@implementation UIViewController (SwizzlingLifeCycle)

- (NSArray *)getLifeCycleActions {
    NSArray *actions = objc_getAssociatedObject(self, QSLifeCycleKey);
    if ([actions isKindOfClass:[NSArray class]]) {
        return actions;
    }
    return @[];
}

- (void)setLifeCycleActions:(NSArray *)lifeCycleActions {
    objc_setAssociatedObject(self, QSLifeCycleKey, lifeCycleActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (BOOL)registerLifeCycleAction:(QSLifeCycleActionBase *)lifeCycleAction {
    if (![lifeCycleAction isKindOfClass:[QSLifeCycleActionBase class]]) {
        return NO;
    }
    
    NSArray *actions = [self getLifeCycleActions];
    for (QSLifeCycleActionBase *action in actions) {
        if ([lifeCycleAction.identifier isEqualToString:action.identifier]) {
            return YES;
        }
    }
    
    NSMutableArray *newActions = [[NSMutableArray alloc] initWithArray:actions];
    [newActions addObject:lifeCycleAction];
    
    [self setLifeCycleActions:newActions];
    
    return YES;
}

- (BOOL)removeLifeCycleAction:(QSLifeCycleActionBase *)lifeCycleAction {
    if (![lifeCycleAction isKindOfClass:[QSLifeCycleActionBase class]]) {
        return NO;
    }
    
    NSArray *actions = [self getLifeCycleActions];
    NSMutableArray *newActions = [[NSMutableArray alloc] initWithArray:actions];
    
    for (QSLifeCycleActionBase *action in actions) {
        if (lifeCycleAction == action) {
            [newActions removeObject:action];
            return YES;
        }
    }
    
    return NO;
}

- (void)removeAllAction {
    [self setLifeCycleActions:nil];
}

#pragma mark - swizzling methods

- (void)actionPerformSelector:(QSActionBlock)block {
    NSArray *actions = [self getLifeCycleActions];
    
    for (QSLifeCycleActionBase* action in actions) {
        if (block) {
            block(action);
        }
    }
}

- (void)QS_viewDidLoad {
    [self actionPerformSelector:^(QSLifeCycleActionBase *action) {
        if ([action respondsToSelector:@selector(hostViewDidLoadController:)]) {
            [action hostViewDidLoadController:self];
        }
    }];
}

- (void)QS_viewWillAppear:(BOOL)animated {
    [self actionPerformSelector:^(QSLifeCycleActionBase *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillAppear:)]) {
            [action hostController:self viewWillAppear:animated];
        }
    }];
}

- (void)QS_viewDidAppear:(BOOL)animated {
    [self actionPerformSelector:^(QSLifeCycleActionBase *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidAppear:)]) {
            [action hostController:self viewDidAppear:animated];
        }
    }];
}

- (void)QS_viewWillDisappear:(BOOL)animated {
    [self actionPerformSelector:^(QSLifeCycleActionBase *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillDisappear:)]) {
            [action hostController:self viewWillDisappear:animated];
        }
    }];
}

- (void)QS_viewDidDisappear:(BOOL)animated {
    [self actionPerformSelector:^(QSLifeCycleActionBase *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidDisappear:)]) {
            [action hostController:self viewDidDisappear:animated];
        }
    }];
}

#pragma mark - other

+ (void)load {
    QS_swizzlingInstanceMethod([self class], @selector(viewDidLoad), @selector(QS_viewDidLoad));
    QS_swizzlingInstanceMethod([self class], @selector(viewWillAppear:), @selector(QS_viewWillAppear:));
    QS_swizzlingInstanceMethod([self class], @selector(viewDidAppear:), @selector(QS_viewDidAppear:));
    QS_swizzlingInstanceMethod([self class], @selector(viewWillDisappear:),@selector(QS_viewWillDisappear:));
    QS_swizzlingInstanceMethod([self class], @selector(viewDidDisappear:), @selector(QS_viewDidDisappear:));
}

@end
