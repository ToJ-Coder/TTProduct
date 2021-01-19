//
//  AppDelegate.m
//  TTTest-iOS
//
//  Created by Toj on 1/19/21.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    ViewController *vc = [ViewController new];
    self.window.rootViewController = vc;
    self.window.bounds = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
