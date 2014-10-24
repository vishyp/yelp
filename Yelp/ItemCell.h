//
//  ItemCell.h
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UIImageView *itemIcon;
@property (weak, nonatomic) IBOutlet UIImageView *starsImage;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *reviews;

@property (weak, nonatomic) IBOutlet UILabel *numReviews;
@end
