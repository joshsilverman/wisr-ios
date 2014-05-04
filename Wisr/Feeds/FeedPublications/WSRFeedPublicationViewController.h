//
//  WSRFeedPublicationViewController.h
//  Wisr
//
//  Created by Josh Silverman on 5/4/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRFeedPublication.h"
#import "WSRAnswerCell.h"

@interface WSRFeedPublicationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *answersTable;
}

@property (nonatomic, strong) WSRFeedPublication *feedPublication;
@property (nonatomic, strong) NSDictionary *answers;
@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, weak) IBOutlet UILabel *questionText;

@end
