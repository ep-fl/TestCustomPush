//
//  Animation.h
//  TestCustomPush
//
//  Created by fl on 26.02.16.
//  Copyright © 2016 LWO LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationPopScaleToCenter : NSObject<UIViewControllerAnimatedTransitioning>

@end

#import "ViewController.h"

@interface AnimationPush : NSObject<UIViewControllerAnimatedTransitioning>
-(instancetype)initFromYcoordinate:(CGFloat)yCoordinate;
@end
