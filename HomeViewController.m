//
//  HomeViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "HomeViewController.h"
#import "PPFeaturedViewCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[PPFeaturedViewCell class] forCellReuseIdentifier:@"PPFeaturedViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPFeaturedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PPFeaturedViewCell"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *header = [NSString stringWithFormat:@"Sections"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0;
}

@end
