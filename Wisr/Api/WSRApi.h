//
//  WSRApi.h
//  Wisr
//
//  Created by Josh Silverman on 5/3/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const baseURLStr;

@interface WSRApi : NSObject

+ (NSURL*)URLForCollection:(NSString*)resource;

@end
