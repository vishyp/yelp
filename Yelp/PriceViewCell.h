//
//  PriceViewCell.h
//  
//
//  Created by Vishy Poosala on 10/21/14.
//
//

#import <UIKit/UIKit.h>

@interface PriceViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegmentControl;
@property (nonatomic) BOOL sortIndex;

@end
