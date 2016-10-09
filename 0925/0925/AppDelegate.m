//
//  AppDelegate.m
//  0925
//
//  Created by Jeff on 9/25/16.
//  Copyright © 2016 Jeff. All rights reserved.
//

#import "AppDelegate.h"
#import <YYKit/YYCache.h>
#import <YYKit/YYDiskCache.h>
#import <YYKit/YYMemoryCache.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    YYCache *cache = [YYCache cacheWithName:@"com.jince.cacheManager"];
    //    cache.diskCache.autoTrimInterval = 10;
//    cache.diskCache.ageLimit = 3600 * 24;
//    [cache.diskCache trimToAge:3600 * 24];///asdf
    cache.diskCache.ageLimit = 10;
    [cache.diskCache trimToAge:10];
    cache.memoryCache.ageLimit = 10;
    [cache.memoryCache trimToAge:10];

//    [cache setObject:@"123" forKey:@"key1"];
    id obj = [cache objectForKey:@"key1"];
    NSLog(@"obj %@", obj);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(80 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id obj = [cache objectForKey:@"key1"];
        id obj2 = [cache.diskCache objectForKey:@"key1"];
        NSLog(@"obj %@, obj2 %@", obj, obj2);
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
