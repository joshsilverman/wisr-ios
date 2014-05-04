//
//  WSRFeedPublication.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRFeedPublication.h"

@implementation WSRFeedPublication

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.questionText = data[@"_question"][@"text"];
    }
    return self;
}

@end
