//
//  WSRAuthenticationViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/17/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAuthenticationViewController.h"

@interface WSRAuthenticationViewController ()

@end

@implementation WSRAuthenticationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    self.loadingIndicator.center = self.view.center;
    [self.loadingIndicator setHidesWhenStopped:YES];
    [self.webView addSubview:self.loadingIndicator];
    
    [self fetchAuth];
    
    self.webView.backgroundColor = [UIColor colorWithHexString:ColorNavy];
    self.webView.opaque = NO;
}

-(void)fetchAuth
{
    [self.loadingIndicator startAnimating];
    NSURL *url = [WSRWebViewNavigation URLforAuth];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
    
    // current location
    NSString *currentURLStr = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    NSString *currentHost = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.host"];
    NSString *currentPathname = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.pathname"];
    
    NSString *authURLStr = [[WSRWebViewNavigation URLforAuth] absoluteString];
    NSString *authCallbackPathname = [[WSRWebViewNavigation URLforAuthCallback] path];

    if ([currentURLStr isEqualToString:authURLStr]) {}
    else if ([currentHost isEqualToString:@"api.twitter.com"]
             && [currentPathname isEqualToString:@"/oauth/authenticate"]) {}
    else if ([currentPathname isEqualToString:authCallbackPathname]) {
        NSString *authToken = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
        
        [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:@"authToken"];
        
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBar"];
        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController setViewControllers:[NSArray arrayWithObject:controller] animated:YES];
    }
}


@end
