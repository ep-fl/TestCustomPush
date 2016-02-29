//
//  ViewController.m
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import "ViewController.h"

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
    [self.view addSubview:self.viewForTransform];
}

#pragma mark - Actions

-(void)defaultPush {
    UIViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI

-(UIView *)viewForTransform {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen.bounds) - heightBottomView, CGRectGetWidth(UIScreen.mainScreen.bounds), heightBottomView)];
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
