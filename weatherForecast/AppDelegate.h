//
//  AppDelegate.h
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) UINavigationController *navigationController;

@property(nonatomic, retain) NSArray *arrLocations;
@property(nonatomic, retain) NSString *selectedLocation;
@property(nonatomic, retain) NSString *previousLocation;
@property(nonatomic, retain) NSMutableArray *arrForeCastData;

@end
