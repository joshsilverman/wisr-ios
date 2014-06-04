//
//  WSRSecondViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRProfileViewController.h"

@interface WSRProfileViewController ()

@end

@implementation WSRProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchProfile];

    NSString *bg_color_stripped = @"202734";
    self.webView.backgroundColor = [UIColor colorWithHexString:bg_color_stripped];
    self.webView.opaque = NO;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self fetchProfile];
//    
//    NSString *bg_color_stripped = @"202734";
//    self.webView.backgroundColor = [UIColor colorWithHexString:bg_color_stripped];
//    self.webView.opaque = NO;
//}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//     [self.webView loadHTMLString:@"" baseURL:nil];
//}

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
