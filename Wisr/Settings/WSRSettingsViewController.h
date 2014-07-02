//
//  WSRSettingsViewController.h
//  Wisr
//
//  Created by Josh Silverman on 6/14/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSRAsker.h"
#import "UIColor+HexColors.h"

@interface WSRSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *signout;
@property (strong, nonatomic) IBOutlet UILabel *version;

@end
