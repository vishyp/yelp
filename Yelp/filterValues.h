//
//  filterValues.h
//  Yelp
//
//  Created by Vishy Poosala on 10/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface filterValues : NSObject
@property (nonatomic) float radius;
@property (nonatomic) BOOL doDeals;
@property (nonatomic) int sortBy;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *radiusLabel;

@end
