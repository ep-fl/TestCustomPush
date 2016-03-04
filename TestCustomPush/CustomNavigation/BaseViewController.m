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
    CGFloat _yCoordinateToPush;
    UIViewController *_viewControllerToAdd;
}

-(void)loadView {
    [super loadView];
    self.navigationController.delegate = self;
    _yCoordinateToPush = CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView;
}

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
//        return [[AnimationPopScaleToCenter alloc] init];
    } else if (operation == UINavigationControllerOperationPush) {
        return [[AnimationPush alloc] initFromYcoordinate:_yCoordinateToPush];
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

        CGFloat yTranslation = [recognizer translationInView:recognizer.view].y;
        if (yTranslation < 0) {
            _viewControllerToAdd = [self viewControllerToPush];
            _viewControllerToAdd.view.frame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView, CGRectGetWidth(UIScreen.mainScreen.bounds), heightBottomView);
            [self.view addSubview:_viewControllerToAdd.view];
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint newCoord = [recognizer locationInView:view];
        CGFloat newY = _panCoordinate.y - newCoord.y;
        CGFloat newHeight = CGRectGetHeight(view.frame) + newY;

        _yCoordinateToPush = recognizer.view.frame.origin.y - newY;
        _viewControllerToAdd.view.frame = CGRectMake(0, _yCoordinateToPush, recognizer.view.frame.size.width, newHeight);
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if ([recognizer velocityInView:view].x > 0) {
            [self.navigationController pushViewController:_viewControllerToAdd animated:YES];
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect r = _viewControllerToAdd.view.frame;
                r.origin.y = CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView;
                r.size.height = heightBottomView;
                _viewControllerToAdd.view.frame = r;
                _viewControllerToAdd.view.alpha = 0.3;
            } completion:^(BOOL finished) {
                [_viewControllerToAdd.view removeFromSuperview];
            }];
        }
        
        _yCoordinateToPush = CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView;
        
        self.interactionController = nil;
    }
}

@end
