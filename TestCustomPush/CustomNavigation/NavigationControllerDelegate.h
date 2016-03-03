//
//  NavigationControllerDelegate.h
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animations/Animation.h"

@interface NavigationControllerDelegate : NSObject<UINavigationControllerDelegate>
-(instancetype)initWithNawigationController:(UINavigationController *)navigationController;

-(void)viewToAddPan:(UIView *)view;
@end
