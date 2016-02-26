//
//  NavigationControllerDelegate.m
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "Animations/AnimationScaleToCenter.h"

@interface NavigationControllerDelegate()
@property(nonatomic, weak) UINavigationController *navigationController;
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation NavigationControllerDelegate {
    AnimationScaleToCenter *_animationScaleToCenter;
}

-(instancetype)initWithNawigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _animationScaleToCenter = [[AnimationScaleToCenter alloc] init];
        
        _navigationController = navigationController;
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_navigationController.view addGestureRecognizer:panRecognizer];
    } return self;
}

#pragma mark - UINavigationControllerDelegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return _animationScaleToCenter;
    } else if (operation == UINavigationControllerOperationPush) {
        
    }
    
    return nil;
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

- (void)pan:(UIPanGestureRecognizer*)recognizer {
    UIView *view = self.navigationController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (self.navigationController.viewControllers.count > 1) {
            CGPoint location = [recognizer locationInView:view];
            if (location.x <  CGRectGetMidX(view.bounds)) { // left half
                self.interactionController = [UIPercentDrivenInteractiveTransition new];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

@end
