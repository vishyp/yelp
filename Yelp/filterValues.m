//
//  filterValues.m
//  Yelp
//
//  Created by Vishy Poosala on 10/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "filterValues.h"

@implementation filterValues
- (id) init {
    self = [super init];
    
    self.radius = -1;
    self.doDeals = YES;
    self.category = [[NSMutableString alloc] initWithString:@"restaurants"];
    self.sortBy = 0;
    self.radiusLabel = [[NSMutableString alloc] initWithString:@"auto"];
    
    NSLog(@"filter init %@", self.radiusLabel);
    
    return self;
}



- (NSString*)description
{
    return [NSString stringWithFormat:@"Filters = doDeals: %d,  sortByIndex: %d,  radius: %@, category: %@", self.doDeals, self.sortBy, self.radiusLabel, self.category];
}


@end
