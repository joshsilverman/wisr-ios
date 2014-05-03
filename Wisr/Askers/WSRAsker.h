//
//  WSRAsker.h
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRAsker : NSObject

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *subjectURL;

- (id)initWithJSONData:(NSDictionary*)data;

@end
