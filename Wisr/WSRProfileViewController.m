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
}

-(void)fetchProfile
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/sign_in"];
    [WSRWebViewNavigation navigate:self.webView withURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
