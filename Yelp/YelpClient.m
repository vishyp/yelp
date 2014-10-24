//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term offset:(int)oset  success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSString *ostr = [[NSString alloc] initWithFormat:@"%d", oset];

    NSDictionary *parameters = @{@"term": term, @"ll" : @"37.77493,-122.419415", @"offset":ostr};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term applyFilters:(filterValues *)filters offset:(int)oset location:(CLLocationCoordinate2D )coord  success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSLog(@"applying filters : %@, term = %@", filters, term);
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSString *sort = [[NSString alloc] initWithFormat:@"%d", filters.sortBy];
    
    NSDictionary *parameters;
    NSString *ostr = [[NSString alloc] initWithFormat:@"%d", oset];
    
    NSString *lstr = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude, coord.longitude] ;
    NSLog(@"%@", lstr);
    if (filters) {
        parameters = @{@"term": term, @"ll" :lstr, @"deals_filter":filters.doDeals?@"true":@"false",
            @"sort":sort, @"radius_filter":@"10000", @"category_filter":filters.category, @"offset":ostr};
        
    } else {
        parameters = @{@"term": term, @"ll" :lstr, @"offset":ostr};
    }
 return [self GET:@"search" parameters:parameters success:success failure:failure];
}


@end
