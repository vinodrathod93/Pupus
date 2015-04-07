//
//  VideosViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 16/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "VideosViewController.h"

@interface VideosViewController ()

@end

@implementation VideosViewController

//-(void)awakeFromNib {
//    self.tabBarItem.image = [[UIImage imageNamed:@"Explain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.title = nil;
//    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Selected_Explain3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



-(IBAction)showMessage:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello, World" message:@"This is my First App" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Awesome" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end