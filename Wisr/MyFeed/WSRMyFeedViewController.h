//
//  WSRSecondViewController.h
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRWebViewNavigation.h"
#import "UIColor+HexColors.h"

@interface WSRMyFeedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;

@end
