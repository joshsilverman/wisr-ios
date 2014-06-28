//
//  WSRApi.m
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRApi.h"

//NSString * const BaseURLStr = @"https://www.wisr.com";
NSString * const BaseURLStr = @"http://localhost:3000";

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
                                  BaseURLStr,
                                  resource];
    NSURL *url = [NSURL URLWithString:urlWithParamsStr];
    return url;
}

+(NSURL*)URLWithToken: (NSString *)path
{
    NSString *authToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"];
    NSString *strURL = [NSString stringWithFormat:@"%@/%@.json?a=%@",
                        BaseURLStr,
                        path,
                        authToken];
    NSString *escapedURLStr = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedURLStr];
    
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

+ (void)post:(NSURL*)url withData:(NSDictionary*)params withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))successHandler
{
    NSURLSession *session = [self getSession];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *postString = @"";
    for (NSString *key in [params allKeys]) {
        postString = [NSString stringWithFormat:@"%@&%@=%@",
                      postString, key, params[key]];
    }
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                successHandler(data, response, error);
                                            }];
    
    [task resume];
}

@end
