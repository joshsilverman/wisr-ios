//
//  WSRWebViewNavigation.m
//  Wisr
//
//  Created by Josh Silverman on 5/13/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRWebViewNavigation.h"

@implementation WSRWebViewNavigation

+(NSURL*)URLforAsker: (WSRAsker *)asker forResource:(NSString *)resource
{
    if ([resource isEqualToString:@"feed"]) {
        NSString *strURL = [NSString stringWithFormat:@"%@/%@",
                            BaseURLStr,
                            asker.subjectURL];
        NSURL *url = [NSURL URLWithString:strURL];
        return url;
    } else {
        return nil;
    }
}

+(void)navigate: (UIWebView *)webView withURL:(NSURL*)url
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setValue: @"phone" forHTTPHeaderField: @"Wisr-Variant"];
    [webView loadRequest:urlRequest];
}

@end
