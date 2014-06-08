//
//  WSRFeedsViewController.h
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRApi.h"
#import "WSRAsker.h"
#import "WSRWebViewNavigation.h"
#import "UIColor+HexColors.h"

@interface WSRFeedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBarItem;
@property (nonatomic, strong) WSRAsker *asker;
@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;

@end
