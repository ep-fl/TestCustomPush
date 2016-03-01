//
//  AppDelegate.h
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
//CustomPush
#import "NavigationControllerDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic) NavigationControllerDelegate *navigationDelegate;

@end

