//
//  OnOffViewCell.h
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnOffViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *onOffSwitch;

@property (weak, nonatomic) IBOutlet UILabel *onOffLabel;
@end
