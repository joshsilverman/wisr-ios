//
//  WSRApi.h
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRApi : NSObject

extern NSString* const BaseURLStr;

+ (NSURLSession*)getSession;
+ (NSURL*)URLForCollection:(NSString*)resource;
+ (NSURL*)URLWithToken: (NSString *)path;

+ (void)noConnectionAlert;
+ (void)getJSON:(NSURL*)url withSuccessHandler:(void (^)(NSArray *JSON))successHandler;
+ (void)post:(NSURL*)url withData:(NSDictionary*)params withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))successHandler;

@end
