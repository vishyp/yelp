//
//  DropDownViewCell.m
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "DropDownViewCell.h"

@implementation DropDownViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.buttonClicked = NO;

    // Configure the view for the selected state
}
- (void) setButtonColor {
    if (self.buttonClicked) self.dropDownButton.backgroundColor = [UIColor greenColor];
    else self.dropDownButton.backgroundColor = [UIColor redColor];
    NSLog(@"set rad or cat %@", self.fvc.filters);
    if (self.isRadius) self.fvc.filters.radiusLabel = self.dropDownLabel.text;
    else self.fvc.filters.category = self.dropDownLabel.text;
    
    NSLog(@"set rad or cat %@", self.fvc.filters);
}

- (IBAction)buttonClicked:(id)sender {
    NSLog(@"button clicked");
    self.buttonClicked = !self.buttonClicked;
    [self setButtonColor];
}

@end
