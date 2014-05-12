//
//  WSRApi.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRApi.h"

//NSString * const baseURLStr = @"https://www.wisr.com";
NSString * const baseURLStr = @"http://localhost:3000";

@implementation WSRApi

+ (NSURLSession*)getSession
{
    static NSURLSession *session;
    
    if (session) {
        return session;
    } else {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return session;
}

+ (NSURL*)URLForCollection:(NSString*)resource
{
    NSString *urlWithParamsStr = [NSString stringWithFormat:@"%@/%@.json",
                                  baseURLStr,
                                  resource];
    NSURL *url = [NSURL URLWithString:urlWithParamsStr];
    return url;
}

+ (void)noConnectionAlert
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

+ (void)getJSON:(NSURL*)url withSuccessHandler:(void (^)(NSArray *JSON))successHandler
{
    NSURLSession *session = [self getSession];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithURL:url
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (!error) {
                        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                        if (httpResp.statusCode == 200) {
                            NSError *jsonError;
                            
                            NSArray *JSON =
                            [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
                            
                            if (!jsonError) {
                                successHandler(JSON);
                            }
                        }
                    } else {
                        [WSRApi noConnectionAlert];
                    }
                }];
    
    [dataTask resume];
}

@end
