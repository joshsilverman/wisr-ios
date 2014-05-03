//
//  WSRAsker.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAsker.h"

@implementation WSRAsker

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.subject = data[@"subject"];
    }
    return self;
}

@end
