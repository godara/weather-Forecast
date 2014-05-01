//
//  ViewController.h
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *appDelegate;
}
- (IBAction)btnSubmit_click:(id)sender;
- (IBAction)btnCurrentLocation_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtLocation;
@property (strong, nonatomic) IBOutlet UITableView *tblLocations;

@end
