//
//  WSRAuthenticationViewController.h
//  Wisr
//
//  Created by Josh Silverman on 5/17/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRWebViewNavigation.h"
#import "UIColor+HexColors.h"

@interface WSRAuthenticationViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) UIViewController *myFeedView;

@end
