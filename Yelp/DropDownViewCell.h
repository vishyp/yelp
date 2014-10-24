//

//  DropDownViewCell.h
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"
#import "filterValues.h"

@interface DropDownViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *dropDownButton;
@property (weak, nonatomic) IBOutlet UILabel *dropDownLabel;
@property (nonatomic) BOOL buttonClicked;
@property (nonatomic, weak) FilterViewController *fvc;
@property (nonatomic) BOOL isRadius;
@end
