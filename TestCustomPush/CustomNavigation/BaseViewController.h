//
//  BaseViewController.h
//  TestCustomPush
//
//  Created by fl on 03.03.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasePanToPush <NSObject>
@optional
-(UIViewController *)viewControllerToPush;
@end

@interface BaseViewController : UIViewController <BasePanToPush>
-(void)viewWithPanGesturePush:(UIView *)view;
@end
