//
//  WSRQuestionViewController.m
//  Wisr
//
//  Created by Josh Silverman on 7/23/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRQuestionViewController.h"

@interface WSRQuestionViewController ()

@end

@implementation WSRQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.webView.backgroundColor = [UIColor colorWithHexString:self.bgColor];
    self.webView.opaque = NO;
    
    [super viewDidLoad];
    [self fetchQuestion];
}

-(void)fetchQuestion
{
    NSURL *url = [WSRWebViewNavigation URLforQuestionID:self.questionId];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
    [self.loadingIndicator startAnimating];
}

- (IBAction)handleDoneButtonTap:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
}

@end
