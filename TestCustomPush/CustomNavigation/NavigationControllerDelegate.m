//
//  NavigationControllerDelegate.m
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "Animations/Animation.h"

@interface NavigationControllerDelegate()
@property(nonatomic, weak) UINavigationController *navigationController;
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation NavigationControllerDelegate {
    CGPoint _panCoordinate;
}

-(instancetype)initWithNawigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _navigationController = navigationController;
    } return self;
}

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
//        return [[AnimationPopScaleToCenter alloc] init];;
    } else if (operation == UINavigationControllerOperationPush) {
        return [[AnimationPush alloc] init];
    }
    
    return nil;
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

#pragma mark - Pan Push

-(void)viewToAddPan:(UIView *)view {
    [view addGestureRecognizer:self.panPopRecognizer];
}

-(UIPanGestureRecognizer *)panPopRecognizer {
    return [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPush:)];
}

- (void)panPush:(UIPanGestureRecognizer*)recognizer {
    UIView *view = recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [UIPercentDrivenInteractiveTransition new];
        
        _panCoordinate = [recognizer locationInView:view];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint newCoord = [recognizer locationInView:view];
        CGFloat newY = _panCoordinate.y - newCoord.y;
        
        if (newY > heightBottomView || newY < CGRectGetHeight(UIScreen.mainScreen.bounds)) {
            CGFloat newHeight = CGRectGetHeight(view.frame) + newY;
            recognizer.view.frame = CGRectMake(0, recognizer.view.frame.origin.y - newY, recognizer.view.frame.size.width, newHeight);
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat yPoint = fabs([recognizer velocityInView:view].y);
        if (yPoint > 12) {
            [self.interactionController finishInteractiveTransition];
        } else {
            view.frame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView, CGRectGetWidth(UIScreen.mainScreen.bounds), heightBottomView);
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

/*
#pragma mark - Pan Pop

-(UIPanGestureRecognizer *)panPopRecognizer {
    return [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pop:)];
}

- (void)pop:(UIPanGestureRecognizer*)recognizer {
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
*/

@end
