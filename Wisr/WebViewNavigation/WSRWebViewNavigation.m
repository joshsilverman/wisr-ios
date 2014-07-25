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
        NSString *authToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
        NSString *strURL = [NSString stringWithFormat:@"%@/%@?a=%@",
                            BaseURLStr,
                            asker.subjectURL,
                            authToken];
        NSString *escapedURLStr = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:escapedURLStr];
        return url;
    } else {
        return nil;
    }
}


+(NSURL*)URLWithToken: (NSString *)path
{
    NSString *authToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
    NSString *strURL = [NSString stringWithFormat:@"%@/%@?a=%@",
                        BaseURLStr,
                        path,
                        authToken];
    NSString *escapedURLStr = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedURLStr];
    
    return url;
}

+(NSURL*)URLforQuestionID: (NSInteger *)questionId
{
    NSString *authToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
    NSString *strURL = [NSString stringWithFormat:@"%@/questions/%@?a=%@",
                        BaseURLStr,
                        questionId,
                        authToken];
    NSString *escapedURLStr = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedURLStr];
    
    return url;
}

+(NSURL*)URLforAuth
{
    NSString *strURL = [NSString stringWithFormat:@"%@/users/sign_in", BaseURLStr];
    NSURL *url = [NSURL URLWithString:strURL];
    return url;
}

+(NSURL*)URLforAuthCallback
{
    NSString *strURL = [NSString stringWithFormat:@"%@/users/auth/twitter/callback", BaseURLStr];
    NSURL *url = [NSURL URLWithString:strURL];
    return url;
}

+(void)navigate: (UIWebView *)webView withURL:(NSURL*)url
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setValue: @"phone" forHTTPHeaderField: @"Wisr-Variant"];
    [webView loadRequest:urlRequest];
}

@end
