//
//  WSRAsker.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAsker.h"

NSString * const ColorWhite = @"fdfcfa";

@implementation WSRAsker

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.id = [data[@"id"] integerValue];
        self.subject = data[@"subject"];
        self.subjectURL = data[@"subject_url"];
        self.styles = data[@"styles"];
    }
    return self;
}

@end
