//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "ItemCell.h"
#import "FilterViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MapViewController.h"

NSString * const kYelpConsumerKey = @"DLEdcJsU-tly3bq4G2-ECw";
NSString * const kYelpConsumerSecret = @"vRMd46D-sD71kr6Xd8BPdVgFsKo";
NSString * const kYelpToken = @"87FVg_whyGm7VpkjNpRZFnwqv35Ndgcs";
NSString * const kYelpTokenSecret = @"0-no1vOQ2-_QblyMsR3-9jQqlx4";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) BOOL isSearched;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSMutableArray *newitems;
@property (strong, nonatomic) NSArray *searchedItems;
@property (strong, nonatomic)FilterViewController *fvc;
@property (strong, nonatomic)MapViewController *lvc;

@end

@implementation MainViewController
BOOL startInfScroll = NO;
BOOL isMain = YES;
NSMutableString *searchTerm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    searchTerm = [[NSMutableString alloc] initWithString:@"Thai"];
    if (self) {
        self.location = CLLocationCoordinate2DMake(37.77493, -122.419415);


        self.doFilter = NO;
        self.fvc = [[FilterViewController alloc] init];
        self.lvc = [[MapViewController alloc] init];
        self.lvc.firstVC = self;
        self.fvc.firstVC = self;
        //self.items = [[NSMutableArray alloc] initWithCapacity:20];

        
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:searchTerm applyFilters:nil offset:0 location:self.location
                            success:^(AFHTTPRequestOperation *operation, id response) {
            self.items = [response[@"businesses"] mutableCopy];
            [self.tableView reloadData];
            startInfScroll = YES;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}

-(void)filterReady {
    
    self.doFilter = YES;
    [searchTerm setString:@""];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    if (!isMain) return; // to avoid events on the filter table view
    
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - 700;
    
    if (! startInfScroll) return;
    if (contentHeight < 100) return;
    if (actualPosition >= contentHeight) {
        
        startInfScroll = false;
        [self.client searchWithTerm:searchTerm applyFilters:(self.doFilter ? self.fvc.filters : nil) offset:(int)[self.items count] location:self.location success:^(AFHTTPRequestOperation *operation, id response) {
           
            NSLog(@"in scrollviewdidscroll %f, %f", actualPosition, contentHeight);

            for (int i = 0; i < [response[@"businesses"] count]; i++)
            {
                [self.items addObject:[response[@"businesses"] objectAtIndex:i]];
            }
            
            NSLog(@"infin got new stuff! total size %ld", [self.items count]);
            [self.tableView reloadData];
            
            startInfScroll = true;
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];

    }
}

- (void) loadYelpDataIfSearch:(BOOL)isSearch {

    [self.client searchWithTerm:searchTerm applyFilters:(self.doFilter? self.fvc.filters: nil) offset:0 location:self.location success:^(AFHTTPRequestOperation *operation, id response) {
        self.items = [response[@"businesses"] mutableCopy];
        
        if (isSearch) [self.searchDisplayController.searchResultsTableView reloadData];
        else [self.tableView reloadData];

            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    isMain = YES;
    
    [self loadYelpDataIfSearch:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    isMain = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Search";
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    //self.tableView.estimatedRowHeight = 100;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.searchDisplayController.displaysSearchBarInNavigationBar = TRUE;
    self.searchBar = self.searchDisplayController.searchBar;
    self.searchBar.delegate = self;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(showFilters:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attributes forState: UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem new] initWithTitle:@"Map" style:UIBarButtonItemStyleDone target:self action:@selector(showMap:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState: UIControlStateNormal];
                                             
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellReuseIdentifier:@"ItemCell"];

    self.searchDisplayController.searchResultsTableView.rowHeight = 100;
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellReuseIdentifier:@"ItemCell"];
    

}

- (IBAction)showFilters:(id)sender {
    self.doFilter = NO;
    [self.navigationController pushViewController:self.fvc animated:YES];
}

- (IBAction)showMap:(id)sender {
    [self.navigationController pushViewController:self.lvc animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    self.isSearched = YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length == 0)
    {
        self.isSearched = FALSE;
    }
    else
    {
        self.isSearched = TRUE;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchTerm setString:@""];
    NSLog(@"cancel clicked");
    [self loadYelpDataIfSearch:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchTerm setString:searchBar.text];
    [self loadYelpDataIfSearch:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item;
    ItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    item = self.items[indexPath.row];
    
    cell.itemTitle.text = item[@"name"];
    cell.reviews.text = [NSString stringWithFormat:@"%@ %@", item[@"review_count"], @"reviews"];
    
    
    NSArray *addr = [item valueForKeyPath:@"location.display_address"];
    
    if ([addr count] > 1) cell.address.text = [NSString stringWithFormat:@"%@, %@", addr[0], addr[1]];
    NSString *itemIconUrl = item[@"image_url"];
    NSString *starsUrl = item[@"rating_img_url_large"];
  
    
    [cell.itemIcon setImageWithURL:[NSURL URLWithString:itemIconUrl]];
    [cell.starsImage setImageWithURL:[NSURL URLWithString:starsUrl]];
    
    NSArray *categories = item[@"categories"];
    cell.tags.text = @"";
    for (int i = 0; i < [categories count]; i++) {
        if (i != 0) cell.tags.text = [cell.tags.text stringByAppendingString:@", "];
        cell.tags.text = [cell.tags.text stringByAppendingString:categories[i][0]];
    }
    
    float dist = [item[@"distance"] floatValue];
    dist /= 1600;
    cell.distance.text = [NSString stringWithFormat:@"%0.2f mi", dist];
    
    /*@property (weak, nonatomic) IBOutlet UILabel *distance;
    @property (weak, nonatomic) IBOutlet UILabel *cost;
   */

    // [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //NSLog(@"asked for search row");
        }
    else {
        //NSLog(@"asked for table row");

    }
    return cell;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
