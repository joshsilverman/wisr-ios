//
//  WSRFeedPublicationViewController.m
//  Wisr
//
//  Created by Josh Silverman on 5/4/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRFeedPublicationViewController.h"

@interface WSRFeedPublicationViewController ()

@end

@implementation WSRFeedPublicationViewController

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
    [super viewDidLoad];

    _questionText.text = _feedPublication.questionText;
    _answers = _feedPublication.answers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_answers allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"AnswerCell";
    
    WSRAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[_answers allValues] objectAtIndex:indexPath.row];
    return cell;
}

@end
