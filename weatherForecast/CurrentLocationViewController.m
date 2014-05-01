//
//  CurrentLocationViewController.m
//  weatherForecast
//
//  Created by vritika_godara on 01/05/14.
//  Copyright (c) 2014 vritika. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import "ForecastTableViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController
@synthesize mapViewCurrent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    mapViewCurrent.showsUserLocation = YES;
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    CLLocationCoordinate2D noLocation = mapViewCurrent.userLocation.location.coordinate;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000);
    MKCoordinateRegion adjustedRegion = [self.mapViewCurrent regionThatFits:viewRegion];
    [self.mapViewCurrent setRegion:adjustedRegion animated:YES];
    self.mapViewCurrent.showsUserLocation = YES;
}

-(void)getAddressFromCurruntLocation:(CLLocation *)location{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [SVProgressHUD showWithStatus:@"Updating"];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             [_lblLocation setText:[NSString stringWithFormat:@"%@ , %@",[placemark locality],[placemark administrativeArea]]];
             appDelegate.selectedLocation = [NSString stringWithFormat:@"%@ , %@",[placemark locality],[placemark administrativeArea]];
         }
         [SVProgressHUD dismiss];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [mapViewCurrent removeAnnotations:mapViewCurrent.annotations];
    mapViewCurrent.centerCoordinate = userLocation.location.coordinate;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    [point setCoordinate:mapViewCurrent.userLocation.coordinate];
    NSLog(@"point : %f", mapViewCurrent.userLocation.coordinate.latitude);
    [point setTitle:@"you are here"];
    [mapViewCurrent addAnnotation:point];
    [self getAddressFromCurruntLocation:mapViewCurrent.userLocation.location];
}

- (IBAction)btnGetForecast_click:(id)sender {
    ForecastTableViewController *ftvc = [[ForecastTableViewController alloc] init];
    [self.navigationController pushViewController:ftvc animated:YES];
}
@end
