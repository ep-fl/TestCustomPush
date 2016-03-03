//
//  BaseViewController.m
//  TestCustomPush
//
//  Created by fl on 03.03.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "BaseViewController.h"
//
#import "Animations/Animation.h"

@interface BaseViewController()<UINavigationControllerDelegate>
@property(nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation BaseViewController {
    CGPoint _panCoordinate;
}

-(void)loadView {
    [super loadView];
    self.navigationController.delegate = self;
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

-(void)viewWithPanGesturePush:(UIView *)view {
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

@end
