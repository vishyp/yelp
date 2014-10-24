//
//  MainViewController.h
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController
@property (nonatomic) BOOL doFilter;
@property (nonatomic) CLLocationCoordinate2D location;
- (void) filterReady;

@end
