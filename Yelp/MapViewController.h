//
//  MapViewController.h
//  Yelp
//
//  Created by Vishy Poosala on 10/24/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MainViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) MainViewController *firstVC;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarButton;

@end
