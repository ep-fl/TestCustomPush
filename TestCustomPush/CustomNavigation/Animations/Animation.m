//
//  Animation.m
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "Animation.h"

@implementation AnimationPopScaleToCenter

-(NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation AnimationPush {
    CGFloat _yCoordinate;
}

-(instancetype)initFromYcoordinate:(CGFloat)yCoordinate {
    if (self = [super init]) {
        _yCoordinate = yCoordinate;
    } return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect r = toVC.view.frame;
    r.origin.y = _yCoordinate;
    toVC.view.frame = r;
    
//    toVC.view.alpha = 0;
    [containerView addSubview:toVC.view];
    
    CGAffineTransform xForm = toVC.view.transform;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformScale(xForm, 1, 1);
        
        toVC.view.frame = UIScreen.mainScreen.bounds;
        toVC.view.transform = CGAffineTransformMakeTranslation(1, 1);
    } completion:^(BOOL finished) {
        toVC.view.frame = UIScreen.mainScreen.bounds;
        fromVC.view.transform = CGAffineTransformScale(xForm, 1, 1);
        [transitionContext completeTransition:YES];
    }];
}

@end