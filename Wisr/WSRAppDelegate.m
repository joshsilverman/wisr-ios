//
//  WSRAppDelegate.m
//  Wisr
//
//  Created by Josh Silverman on 5/2/14.
//  Copyright (c) 2014 Wisr. All rights reserved.
//

#import "WSRAppDelegate.h"

@implementation WSRAppDelegate
{
    NSMutableArray *_askers;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initAppearance];
    
	if (launchOptions != nil)
	{
		NSDictionary *notificationDict = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (notificationDict != nil)
		{
			NSLog(@"Launched from push notification: %@", notificationDict);
            [self directAccordingToNotificationDict:notificationDict];
		}
	}
    
    return YES;
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
    [self directAccordingToNotificationDict:userInfo];
}

- (void)directAccordingToNotificationDict:(NSDictionary*)notificationDict
{
    if ([[notificationDict valueForKey:@"path"] isEqualToString:@"question"]) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        tabBarController.selectedIndex = 0;

        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UINavigationController *navController = (UINavigationController*)[mainStoryboard
                                                                       instantiateViewControllerWithIdentifier: @"QuestionNavigationController"];
        navController.navigationBar.barTintColor = [UIColor colorWithHexString:[notificationDict valueForKey:@"bg_color"]];

        WSRQuestionViewController *questionController = navController.viewControllers[0];
        questionController.askerId = [notificationDict valueForKey:@"asker_id"];
        questionController.questionId = [notificationDict valueForKey:@"question_id"];
        questionController.bgColor = [notificationDict valueForKey:@"bg_color"];
        
        [tabBarController presentViewController:navController animated:YES completion:nil];
    }
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    
    NSURL *url = [WSRApi URLWithToken:@"users/register_device_token"];
    NSDictionary *params = @{@"token": deviceToken};
    [WSRApi post:url withData:params withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {}];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)initAppearance
{
    UIColor *wisrColor = [UIColor colorWithHexString:@"202734"];
    
    [[UITabBar appearance] setBarTintColor:wisrColor];
    [[UITabBar appearance] setTintColor: [UIColor colorWithHexString:ColorWhite]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:wisrColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor colorWithHexString:ColorWhite]}];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:wisrColor];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
