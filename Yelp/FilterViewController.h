//
//  FilterViewController.h
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "filterValues.h"

@interface FilterViewController : UIViewController
@property (weak, nonatomic) MainViewController *firstVC;
@property (strong, nonatomic) filterValues *filters;
@end
