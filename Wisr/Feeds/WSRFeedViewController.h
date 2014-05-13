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

@interface WSRFeedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WSRAsker *asker;

@end
