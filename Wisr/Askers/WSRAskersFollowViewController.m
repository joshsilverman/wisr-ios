//
//  WSRAskersViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAskersFollowViewController.h"

@interface WSRAskersFollowViewController ()

@property (nonatomic, strong) NSArray *askers;
@property (nonatomic, strong) NSMutableArray *followIds;

@end

@implementation WSRAskersFollowViewController

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
    [self fetchFollows];
    self.view.backgroundColor = [UIColor colorWithHexString:ColorWhite];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)fetchFollows;
{
    [WSRApi getJSON:[WSRApi URLWithToken: @"users/wisr_follow_ids"]
 withSuccessHandler:^(NSArray *JSON){
     [[NSUserDefaults standardUserDefaults] setObject:JSON forKey:@"followIds"];
     
     dispatch_async(dispatch_get_main_queue(), ^{
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         [self fetchAskers];
     });
 }];
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
         }
     }
     
     self.askers = askersFound;
     
     dispatch_async(dispatch_get_main_queue(), ^{
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         [self.tableView reloadData];
     });
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.askers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AskerFollowCell"
                                                                    forIndexPath:indexPath];

    WSRAsker *asker = (self.askers)[indexPath.row];
    cell.textLabel.text = asker.subject;
    
    UILabel *colorlabel = (UILabel *)[cell viewWithTag:1];
    NSString *silhouette_color = asker.styles[@"silhouette_color"];
    NSString *silhouette_color_stripped = [silhouette_color substringFromIndex:1];
    colorlabel.backgroundColor = [UIColor colorWithHexString:silhouette_color_stripped];
    cell.backgroundColor = [UIColor colorWithHexString:ColorWhite];
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = switchView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BOOL switchState =  [[[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"] containsObject:@(asker.id)];
    
    [switchView setOn:switchState animated:NO];
    [switchView addTarget:self
                   action:@selector(switchChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    UITableViewCell *cell = (UITableViewCell *)switchControl.superview.superview;
    UITableView *tableView = (UITableView *)cell.superview.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    WSRAsker *asker = (self.askers)[indexPath.row];
    
    if (switchControl.isOn) {
        [self switchedOn:switchControl forAsker:asker];
    } else {
        [self switchedOff:switchControl forAsker:asker];
    }
}

- (void) switchedOn:(UISwitch*) switchControl forAsker:(WSRAsker*) asker {
    NSURL *url = [WSRApi URLWithToken:@"relationships"];
    NSDictionary *params = @{@"followed_id": [@(asker.id) stringValue]};
    
    [WSRApi post:url withData:params withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"] containsObject:@(asker.id)]) {
            NSMutableArray *followIds = [[[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"] mutableCopy];
            [followIds addObject:@(asker.id)];
            [[NSUserDefaults standardUserDefaults] setObject:followIds forKey:@"followIds"];
        }
    }];
}

- (void) switchedOff:(UISwitch*) switchControl forAsker:(WSRAsker*) asker {
    NSURL *url = [WSRApi URLWithToken:@"relationships/deactivate"];
    NSDictionary *params = @{@"followed_id": [@(asker.id) stringValue]};
    
    [WSRApi post:url withData:params withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"] containsObject:@(asker.id)]) {
            NSMutableArray *followIds = [[[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"] mutableCopy];
            [followIds removeObject:@(asker.id)];
            [[NSUserDefaults standardUserDefaults] setObject:followIds forKey:@"followIds"];
        }
    }];
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


@end
