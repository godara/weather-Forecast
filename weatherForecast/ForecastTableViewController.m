//
//  ForecastTableViewController.m
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import "ForecastTableViewController.h"
#import "SVProgressHUD.h"
#import "ForecastTableViewCell.h"
#import "Constants.h"

@interface ForecastTableViewController ()

@end

@implementation ForecastTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(![appDelegate.previousLocation isEqualToString: appDelegate.selectedLocation]){
    NSString *urlString = [NSString stringWithFormat:WEBSERVICE_URL,appDelegate.selectedLocation,COUNT,APPID];
    NSString *properlyEscapedURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:properlyEscapedURL];
    NSLog(@"url : %@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [SVProgressHUD show];
        
    //webservice call
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        appDelegate.arrForeCastData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD dismiss];
        NSLog(@"%@",[appDelegate.arrForeCastData valueForKey:@"cod"]);
        if([[appDelegate.arrForeCastData valueForKey:@"cod"]  isEqual: @"404"]){
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Location" message:@"No weather forcast found for this location" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [errorAlert show];
        }
        [self.tableView reloadData];
    }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[appDelegate.arrForeCastData valueForKey:@"list"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"ForecastTableViewCell";
    ForecastTableViewCell *cell = (ForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell==nil) {
        NSArray *cellObjects=[[NSBundle mainBundle]loadNibNamed:@"ForecastTableViewCell" owner:self options:nil];
        
        for (id currentObject in cellObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell=(ForecastTableViewCell *)currentObject;
            }
        }
        
    }
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:@"0.##"];
    NSString *strMin = [fmt stringFromNumber:[[[[appDelegate.arrForeCastData valueForKey:@"list"] valueForKey:@"temp"] valueForKey:@"min"]objectAtIndex:indexPath.row]];
    NSString *strMax = [fmt stringFromNumber:[[[[appDelegate.arrForeCastData valueForKey:@"list"] valueForKey:@"temp"] valueForKey:@"max"]objectAtIndex:indexPath.row]];
    NSString *strHumidity = [NSString stringWithFormat:@"%@",[[[appDelegate.arrForeCastData valueForKey:@"list"] valueForKey:@"humidity"] objectAtIndex:indexPath.row]];
    [cell.lblWeather setText:[[[[[appDelegate.arrForeCastData valueForKey:@"list"] valueForKey:@"weather"] valueForKey:@"main"]objectAtIndex:indexPath.row] objectAtIndex:0]];
    [cell.lblMinTemp setText:strMin];
    [cell.lblMaxTemp setText:strMax];
    [cell.lblHumidity setText:strHumidity];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 50)];
    [headerView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:144.0/255.0 blue:118.0/255.0 alpha:1.0]];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.view.frame.size.width, 20)];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle setText:[NSString stringWithFormat:@"%@",appDelegate.selectedLocation]];
    [headerView addSubview:lblTitle];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

@end
