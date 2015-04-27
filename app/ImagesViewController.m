//
//  ImagesViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 22/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "ImagesViewController.h"

@interface ImagesViewController ()

@end

@implementation ImagesViewController


-(void)awakeFromNib {
    self.tabBarItem.image = [[UIImage imageNamed:@"How"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.title = nil;
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Selected_How3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imagesCollectionView = [UICollectionView]
}


@end
