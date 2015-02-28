//
//  ShowMoreViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 16/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "ShowMoreViewController.h"

@interface ShowMoreViewController ()

@end

@implementation ShowMoreViewController

-(void)awakeFromNib {
    self.tabBarItem.image = [[UIImage imageNamed:@"Show"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.title = nil;
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Selected_Show3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
