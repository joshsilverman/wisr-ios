//
//  WSRWebViewNavigation.h
//  Wisr
//
//  Created by Josh Silverman on 5/13/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRAsker.h"
#import "WSRApi.h"

@interface WSRWebViewNavigation : NSObject

+(NSURL*)URLforAsker: (WSRAsker *)asker forResource:(NSString *)resource;
+(NSURL*)URLforAuth;
+(NSURL*)URLforAuthCallback;
+(NSURL*)URLWithToken: (NSString *)path;

+(void)navigate: (UIWebView *)webView withURL:(NSURL*)url;

@end
