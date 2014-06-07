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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchProfile];
    
    [self redirectIfNoFollowIds];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.webView loadHTMLString:@"" baseURL:nil];
}

-(void)fetchProfile
{
    NSURL *url = [WSRWebViewNavigation URLWithToken:@"feeds/index"];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
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
                                                        message:@"Please follow a few subjects and then try visiting your feed."
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

@end
