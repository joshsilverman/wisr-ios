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


@end
