//
//  WSRFeedsViewController.h
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRApi.h"
#import "WSRFeedPublication.h"
#import "WSRAsker.h"

@protocol WSRFeedsViewControllerDelegate <NSObject>

//- (void)feedsViewControllerDidCancel:(WSRFeedsViewController*)controller;
//- (void)feedsViewControllerDoneWithDetails:(WSRFeedsViewController*)controller;

@end

@interface WSRFeedsViewController : UITableViewController

@property (nonatomic, weak) id<WSRFeedsViewControllerDelegate> delegate;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) WSRAsker *asker;

@end
