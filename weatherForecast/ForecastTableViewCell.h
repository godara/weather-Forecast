//
//  ForecastTableViewCell.h
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblWeather;
@property (strong, nonatomic) IBOutlet UILabel *lblMaxTemp;
@property (strong, nonatomic) IBOutlet UILabel *lblMinTemp;
@property (strong, nonatomic) IBOutlet UILabel *lblHumidity;

@end
