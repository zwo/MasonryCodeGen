//
//  AppDelegate.m
//  MasonryCodeGen
//
//  Created by 周维鸥 on 2018/3/29.
//  Copyright © 2018年 周维鸥. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)onGenerateCode:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Masonry_Code_Gen" object:nil];
}

- (void)onClear:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Masonry_Code_Clear" object:nil];
}

@end
