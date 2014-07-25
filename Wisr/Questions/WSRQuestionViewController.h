//
//  WSRQuestionViewController.h
//  Wisr
//
//  Created by Josh Silverman on 7/23/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRWebViewNavigation.h"

@interface WSRQuestionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBarItem;
@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;

@property (nonatomic) NSInteger asker_id;
@property (nonatomic) NSInteger question_id;

@end
