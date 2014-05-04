//
//  WSRFeedPublication.h
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRFeedPublication : NSObject

@property (nonatomic, copy) NSString *questionText;

- (id)initWithJSONData:(NSDictionary*)data;

@end
