//
//  WSRFeedsViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRFeedsViewController.h"

@interface WSRFeedsViewController ()
@property (nonatomic, strong) NSArray *feedPublications;
@end

@implementation WSRFeedsViewController

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
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchFeedPublications];
}

- (void)fetchFeedPublications;
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithURL:[WSRApi URLForCollection:_asker.subjectURL]
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (!error) {
                        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                        if (httpResp.statusCode == 200) {
                            NSError *jsonError;
                            
                            NSArray *askersJSON =
                            [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
                            
                            NSMutableArray *feedPubs = [[NSMutableArray alloc] init];
                            
                            if (!jsonError) {
                                for (NSDictionary *data in askersJSON) {
                                    WSRFeedPublication *pub = [[WSRFeedPublication alloc] initWithJSONData:data];
                                    [feedPubs addObject:pub];
                                }
                            }
                            
                            self.feedPublications = feedPubs;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                [self.tableView reloadData];
                            });
                        }
                    }
                }];
    
    [dataTask resume];
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
    return [self.feedPublications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedPublicationCell";
    WSRFeedsPublicationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSRFeedsPublicationCell *textCell = (WSRFeedsPublicationCell *)cell;
    WSRFeedPublication *pub = _feedPublications[indexPath.row];
    textCell.questionTextLabel.text = pub.questionText;
    textCell.questionTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSRFeedPublication *pub = _feedPublications[indexPath.row];
    NSString *content = pub.questionText;
    
    // Max size you will permit
    CGSize maxSize = CGSizeMake(266, 1000);
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    CGSize size = [content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];

    return size.height + 14;
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
    WSRFeedPublicationViewController *feedPubController = segue.destinationViewController;
    feedPubController.session = _session;
    
    WSRFeedPublication *pub = _feedPublications[[self.tableView indexPathForSelectedRow].row];
    feedPubController.feedPublication = pub;
}

@end
