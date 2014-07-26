//
//  WSRSecondViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRMyFeedViewController.h"

@interface WSRMyFeedViewController ()

@end

@implementation WSRMyFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.backgroundColor = [UIColor colorWithHexString:ColorNavy];
    self.webView.opaque = NO;
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    self.loadingIndicator.center = self.view.center;
    [self.loadingIndicator setHidesWhenStopped:YES];
    [self.webView addSubview:self.loadingIndicator];

    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;

    if (!self.refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                           action:@selector(refreshProfile:)
                 forControlEvents:UIControlEventValueChanged];
        [self.webView.scrollView addSubview:self.refreshControl];
    }
    
    [self loadContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.refreshControl endRefreshing];
    
    if (self.followsChanged) {
        [self loadContent];
        self.followsChanged = FALSE;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
    if (!token) {
        [self loadContent];
    }
}

- (void)loadContent
{
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
    
    if (token) {
        [self fetchProfile:YES];
        [self redirectIfNoFollowIds];
        [self registerForAPNS];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *authNavController = [storyboard instantiateViewControllerWithIdentifier:@"AuthenticationNav"];
        WSRAuthenticationViewController *authController = authNavController.childViewControllers[0];
        [self presentModalViewController:authNavController animated:YES];
        authController.myFeedView = self;
    }
}

-(void)refreshProfile:(UIRefreshControl *)refresh
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"$(window).trigger('ios:refresh')"];
}

-(void)fetchProfile:(BOOL *)loadingIndicator
{
    NSURL *url = [WSRWebViewNavigation URLWithToken:@"feeds/index"];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
    
    if (loadingIndicator) {
        [self.loadingIndicator startAnimating];
    }
}

- (void)registerForAPNS
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)redirectIfNoFollowIds
{
    NSArray *followIds = [[NSUserDefaults standardUserDefaults] valueForKey:@"followIds"];
    
    if (followIds == Nil || [followIds count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Follow subjects"
                                                        message:@"Please follow a few subjects and then visit your feed."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        self.tabBarController.selectedIndex = 2;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // current location
    NSString *currentURLStr = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    NSString *currentHost = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.host"];
    NSString *currentPathname = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.pathname"];
    
    NSString *authURLStr = [[WSRWebViewNavigation URLforAuth] absoluteString];
    [self.loadingIndicator stopAnimating];
    [self.refreshControl endRefreshing];
    
    if ([currentURLStr isEqualToString:authURLStr]) {}
    else if ([currentHost isEqualToString:@"api.twitter.com"]
             && [currentPathname isEqualToString:@"/oauth/authenticate"]) {}
    else if ([currentPathname isEqualToString:@"/users/auth/twitter/callback"]) {
        NSString *documentBody = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
        
        if ([documentBody isEqualToString:@"authenticated"]) {
            self.tabBarController.selectedIndex = 0;
        }
    }
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *URL = [request URL];
    
    NSString *scheme = [URL scheme];
    NSString *host = [URL host];
    
    if ([scheme isEqualToString:@"ios"]) {
        if ([host isEqualToString:@"refreshed"]) {
            [self.refreshControl performSelector:@selector(endRefreshing) withObject:self afterDelay:0.5];
            return NO;
        }
    }
    
    return YES;
}

@end