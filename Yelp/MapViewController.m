//
//  MapViewController.m
//  Yelp
//
//  Created by Vishy Poosala on 10/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
CLLocationCoordinate2D coord;
CLLocationDistance dist;


- (IBAction)zoomClicked:(id)sender {
    NSLog(@"zoom clicked");
    dist /= 2;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (coord, dist, dist);
    [_mapView setRegion:region animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mapView.showsUserLocation = YES;
    //MKUserLocation *userLocation = _mapView.userLocation;
    dist = 20000;

    coord.latitude = 37.77493;
    coord.longitude =  -122.419415;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (coord, dist, dist);
    [_mapView setRegion:region animated:NO];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    
    tapRecognizer.numberOfTouchesRequired = 1;
    
    [self.mapView addGestureRecognizer:tapRecognizer];

}

-(IBAction)foundTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:self.mapView];
    
    CLLocationCoordinate2D tapPoint = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = tapPoint;
    coord = tapPoint;
    
    [self.mapView addAnnotation:point1];
    
    NSLog(@"location = %f", tapPoint.latitude);
    self.firstVC.location = tapPoint;
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
