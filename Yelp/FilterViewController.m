//
//  FilterViewController.m
//  Yelp
//
//  Created by Vishy Poosala on 10/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "PriceViewCell.h"
#import "OnOffViewCell.h"
#import "DropDownViewCell.h"

@interface FilterViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@end

@implementation FilterViewController
NSArray *sectionTitle;

PriceViewCell *pcell;
OnOffViewCell *ocell;
BOOL radiusExpanded = NO;
BOOL catExpanded = NO;
NSArray *categorieLabels;
NSArray *categorieParams;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.title = @"Filters";
    categorieLabels = @[@"Active Life", @"Arts & Entertainment", @"Automotive", @"Restaurants", @"Shopping"];
    categorieParams = @[@"active", @"arts", @"auto", @"restaurants", @"shopping" ];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    
    
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem new] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelFilter:)];
   [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attributes forState: UIControlStateNormal];
    
    
    sectionTitle = @[@"Category", @"Sort", @"Radius", @"Deals"];
    self.filters = [[filterValues alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem new] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(doSearch:)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState: UIControlStateNormal];
    
    self.filterTableView.rowHeight = 40;
    
    self.filterTableView.delegate = self;
    self.filterTableView.dataSource = self;
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"PriceViewCell" bundle:nil] forCellReuseIdentifier:@"PriceViewCell"];
    [self.filterTableView registerNib:[UINib nibWithNibName:@"OnOffViewCell" bundle:nil] forCellReuseIdentifier:@"OnOffViewCell"];
    [self.filterTableView registerNib:[UINib nibWithNibName:@"DropDownViewCell" bundle:nil] forCellReuseIdentifier:@"DropDownViewCell"];


}

- (IBAction)cancelFilter:(id)sender {
    self.firstVC.doFilter = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)doSearch:(id)sender {
    // TODO
    self.filters.doDeals = ocell.onOffSwitch.isOn;
    [self.firstVC filterReady];
    
    self.filters.sortBy = (int) pcell.priceSegmentControl.selectedSegmentIndex;

    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return (catExpanded ? [categorieLabels count] : 3);
            break;
        case 1:
        case 3:
            return 1;
            break;
           
        case 2:
            return (radiusExpanded ? 3: 1);
        default:
            break;
    }
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionTitle objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DropDownViewCell *dcell;
    
    NSLog(@"section %ld, row %ld", (long)indexPath.section, (long)indexPath.row);
    switch (indexPath.section) {
        case 1:
            pcell = [tableView dequeueReusableCellWithIdentifier:@"PriceViewCell"];
            return pcell;

        case 0:
            dcell = [tableView dequeueReusableCellWithIdentifier:@"DropDownViewCell"];
            dcell.isRadius = NO;
            dcell.dropDownLabel.text = categorieParams[indexPath.row];
            dcell.fvc = self;

            return dcell;
            

        case 2:
            dcell = [tableView dequeueReusableCellWithIdentifier:@"DropDownViewCell"];
            dcell.isRadius = YES;
            switch (indexPath.row) {
                case 0:
                    dcell.dropDownLabel.text = @"Auto";
                    break;
                    
                case 1:
                    dcell.dropDownLabel.text = @"0.3 miles";
                    break;
                    
                case 2:
                    dcell.dropDownLabel.text = @"20 miles";
                    break;
                    
                default:
                    dcell = nil;
                    NSLog(@"wrong row for distance!");
                    
            }
            dcell.fvc = self;
            return dcell;

            
        case 3:
            ocell = [tableView dequeueReusableCellWithIdentifier:@"OnOffViewCell"];
            return ocell;
            
        default:
            pcell = [tableView dequeueReusableCellWithIdentifier:@"PriceViewCell"];
            return pcell;
    }
    
    return pcell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        radiusExpanded = !radiusExpanded;
        
            NSIndexPath *path1 = [NSIndexPath indexPathForRow:1 inSection:2];
            NSIndexPath *path2 = [NSIndexPath indexPathForRow:2 inSection:2];
            NSArray *arr = [NSArray arrayWithObjects:path1,path2,nil];
            
            [tableView beginUpdates];
            if (radiusExpanded) {
                [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
            } else {
                [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            }
            [tableView endUpdates];
    } else if (indexPath.section == 0) {
        catExpanded = !catExpanded;
        
        NSMutableArray *pathArr = [[NSMutableArray alloc] initWithCapacity:[categorieLabels count]];
        for (int i = 3; i < [categorieLabels count]; i++) {
              [pathArr addObject:[NSIndexPath indexPathForRow:i inSection:0]] ;
        }
        
        [tableView beginUpdates];
        if (catExpanded) {
            [tableView insertRowsAtIndexPaths:pathArr withRowAnimation:UITableViewRowAnimationBottom];
        } else {
            [tableView deleteRowsAtIndexPaths:pathArr withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView endUpdates];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
