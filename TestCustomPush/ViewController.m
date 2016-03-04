//
//  ViewController.m
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "ViewController.h"
//Push
#import "ViewControllerWithPan.h"

#define button_height 25

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat x = 15;
    CGFloat yDefaultPush = 90;
    
    [self.view addSubview:[self buttonWithPoint:CGPointMake(x, yDefaultPush) title:@"defaultPush" selector:@selector(defaultPush)]];
    
    UIView *view = [self viewForTransform];
    [self.view addSubview:view];
    [super viewWithPanGesturePush:view];
}

#pragma mark - Actions

-(void)defaultPush {
    [self.navigationController pushViewController:self.viewControllerToPush animated:YES];
}

#pragma mark - BasePanToPush

-(UIViewController *)viewControllerToPush {
    return [[ViewControllerWithPan alloc] init];
}

#pragma mark - UI

-(UIView *)viewForTransform {
    UIView *view = [[ViewControllerWithPan alloc] init].view;
    view.frame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView, CGRectGetWidth(UIScreen.mainScreen.bounds), heightBottomView);
    view.backgroundColor = [UIColor greenColor];
    return view;
}

-(UIButton *)buttonWithPoint:(CGPoint)point title:(NSString *)title selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    button.frame = CGRectMake(point.x, point.y, 200, button_height);
    [button setTitle:title forState:UIControlStateNormal];
    if (selector != NULL) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

@end
