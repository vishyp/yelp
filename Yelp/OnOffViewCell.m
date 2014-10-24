//
//  OnOffViewCell.m
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "OnOffViewCell.h"

@implementation OnOffViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)onOffChosen:(id)sender {
    NSLog(@"onfff status: %d", self.onOffSwitch.isOn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
