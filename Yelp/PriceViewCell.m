//
//  PriceViewCell.m
//  
//
//  Created by Vishy Poosala on 10/21/14.
//
//

#import "PriceViewCell.h"

@implementation PriceViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)sortSelected:(UISegmentedControl *)sender {
    // TODO: this is never returning 2!!
    self.sortIndex = sender.selectedSegmentIndex;
    NSLog(@"changed sort index %d", self.sortIndex);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
