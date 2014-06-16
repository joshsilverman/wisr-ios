//
//  WSRSettingsViewController.m
//  Wisr
//
//  Created by Josh Silverman on 6/14/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRSettingsViewController.h"

@interface WSRSettingsViewController ()

@end

@implementation WSRSettingsViewController

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
    self.view.backgroundColor = [UIColor colorWithHexString:ColorNavy];
    
    UIImage *originalImage = [UIImage imageNamed:@"GreyButton"];
    UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [self.signout setBackgroundImage:stretchableImage  forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signout:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authToken"];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.tabBarController.selectedIndex = 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
