//
//  WSRApi.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRApi.h"

NSString * const baseURLStr = @"http://wisr.com";

@implementation WSRApi

+ (NSURL*)URLForCollection:(NSString*)resource
{
    NSString *urlWithParamsStr = [NSString stringWithFormat:@"%@/%@.json",
                                  baseURLStr,
                                  resource];
    NSURL *url = [NSURL URLWithString:urlWithParamsStr];
    return url;
}

@end
