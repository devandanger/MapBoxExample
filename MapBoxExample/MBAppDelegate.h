//
//  MBAppDelegate.h
//  MapBoxExample
//
//  Created by Evan Anger on 3/8/13.
//  Copyright (c) 2013 JPETech LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
