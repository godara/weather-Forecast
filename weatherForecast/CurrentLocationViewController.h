//
//  CurrentLocationViewController.h
//  weatherForecast
//
//  Created by vritika_godara on 01/05/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface CurrentLocationViewController : UIViewController
{
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet MKMapView *mapViewCurrent;
- (IBAction)btnGetForecast_click:(id)sender;
@end
