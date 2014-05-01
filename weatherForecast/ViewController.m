//
//  ViewController.m
//  weatherForecast
//
//  Created by vritika_godara on 29/04/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import "ViewController.h"
#import "ForecastTableViewController.h"
#import "CurrentLocationViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - tableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [appDelegate.arrLocations count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.textLabel setText:[appDelegate.arrLocations objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelegate.previousLocation = appDelegate.selectedLocation;
    appDelegate.selectedLocation = [appDelegate.arrLocations objectAtIndex:indexPath.row];
    
    ForecastTableViewController *ftvc = [[ForecastTableViewController alloc] init];
    [self.navigationController pushViewController:ftvc animated:YES];
    
}


#pragma mark - button clicks

- (IBAction)btnSubmit_click:(id)sender {
    if([_txtLocation.text isEqualToString:@""])
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Enter atleast one location in the textbox" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
    } else{
    appDelegate.arrLocations = [_txtLocation.text componentsSeparatedByString:@","];
    [_tblLocations reloadData];
    }
    [_txtLocation resignFirstResponder];
}

- (IBAction)btnCurrentLocation_click:(id)sender {
    CurrentLocationViewController *clvc = [[CurrentLocationViewController alloc] init];
    [self.navigationController pushViewController:clvc animated:YES];
}
@end
