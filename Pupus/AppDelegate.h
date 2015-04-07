//
//  AppDelegate.h
//  Pupus
//
//  Created by Vinod Rathod on 02/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *))completionHandler;

@end

