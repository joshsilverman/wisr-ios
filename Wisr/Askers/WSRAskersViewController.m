//
//  WSRAskersViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAskersViewController.h"

@interface WSRAskersViewController ()<WSRFeedsViewControllerDelegate>

@property (nonatomic, strong) NSArray *askers;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation WSRAskersViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchAskers];
}

- (void)fetchAskers;
{
    NSMutableArray *askersFound = [[NSMutableArray alloc] init];
    [WSRApi getJSON:[WSRApi URLForCollection:@"askers"]
 withSuccessHandler:^(NSArray *JSON){
     for (NSDictionary *data in JSON) {
         if (![data[@"published"] isKindOfClass:[NSNull class]]
             && ![data[@"subject"] isKindOfClass:[NSNull class]]
             && data[@"published"]) {
             
             WSRAsker *asker = [[WSRAsker alloc] initWithJSONData:data];
             [askersFound addObject:asker];
             
             self.askers = askersFound;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 [self.tableView reloadData];
             });
         }
     }
 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.askers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AskerCell"
                                                            forIndexPath:indexPath];
    
    WSRAsker *asker = (self.askers)[indexPath.row];
    cell.textLabel.text = asker.subject;
    
    return cell;
}

- (void)feedsControllerDone
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WSRFeedsViewController *feed = segue.destinationViewController;
    feed.delegate = self;
    feed.session = _session;
    
    WSRAsker *asker =  _askers[[self.tableView indexPathForSelectedRow].row];
    feed.asker = asker;
}

@end
