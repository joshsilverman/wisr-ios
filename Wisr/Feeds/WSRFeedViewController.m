//
//  WSRFeedsViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRFeedViewController.h"

@interface WSRFeedViewController ()

@end

@implementation WSRFeedViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    self.loadingIndicator.center = self.view.center;
    [self.loadingIndicator setHidesWhenStopped:YES];
    [self.webView addSubview:self.loadingIndicator];
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    NSString *bg_color = self.asker.styles[@"bg_color"];
    NSString *bg_color_stripped;
    if (![bg_color isKindOfClass:[NSNull class]]) {
        bg_color_stripped = [bg_color substringFromIndex:1];
    } else {
        bg_color_stripped = ColorNavy;
    }
    
    self.webView.backgroundColor = [UIColor colorWithHexString:bg_color_stripped];
    self.webView.opaque = NO;
    
    [self fetchFeed];
}

-(void)fetchFeed
{
    NSURL *url = [WSRWebViewNavigation URLforAsker:self.asker forResource:@"feed"];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
    [self.loadingIndicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
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
