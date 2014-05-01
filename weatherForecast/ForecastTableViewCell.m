//
//  ForecastTableViewCell.m
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell
@synthesize lblHumidity,lblMaxTemp,lblMinTemp,lblWeather;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
