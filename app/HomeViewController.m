//
//  HomeViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "HomeViewController.h"
#import "PPFeaturedViewCell.h"
#import "PPHistoryViewCell.h"
#import "PP_MainViewController.h"
#import "PPFeaturedCellView.h"
#import "AppDelegate.h"


@interface HomeViewController ()
{
    NSMutableArray *featured_imgs, *topChart_imgs;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"--------viewDidLoad---------");
    
    self.featuredArray = [NSMutableArray array];
    self.topChartsArray = [NSMutableArray array];
    featured_imgs = [NSMutableArray array];
    topChart_imgs = [NSMutableArray array];
    
    [self.tableView registerClass:[PPFeaturedViewCell class] forCellReuseIdentifier:@"PPFeaturedViewCell"];
    
    UINib *nib = [UINib nibWithNibName:@"PPHistoryViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PPHistoryViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushVC:) name:@"collectionViewDidSelectItem" object:nil];
    
    [self loadImagesInCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--------viewWillAppear----------");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"---------viewDidAppear-----------");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"---------cellForRowAtIndexPath-----------");
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    PPFeaturedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PPFeaturedViewCell"];
    PPHistoryViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"PPHistoryViewCell"];
    
    
    
    switch (indexPath.section) {
        case 0:
            myCell.titleLabel.text = @"The Alchemist";
            return myCell;
            break;
        
        case 1:
            cell.collectionView.collectionData = featured_imgs;
            cell.collectionView.sectionId = [NSNumber numberWithInt:1];
            return cell;
            break;
            
        case 2:
            cell.collectionView.collectionData = topChart_imgs;
            cell.collectionView.sectionId = [NSNumber numberWithInt:2];
            
            return cell;
            break;
            
        case 3:
            cell.collectionView.collectionData = topChart_imgs;
            cell.collectionView.sectionId = [NSNumber numberWithInt:3];
            
            return cell;
            break;
            
        case 4:
            cell.collectionView.collectionData = topChart_imgs;
            cell.collectionView.sectionId = [NSNumber numberWithInt:4];
            
            return cell;
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header;
    
    switch (section) {
        case 0:
            header = [NSString stringWithFormat:@"Last Search"];
            return header;
            break;
            
        case 1:
            header = [NSString stringWithFormat:@"Featured"];
            return header;
            break;
            
        case 2:
            header = [NSString stringWithFormat:@"Top Charts"];
            return header;
            break;
            
        case 3:
            header = [NSString stringWithFormat:@"Categories"];
            return header;
            break;

        case 4:
            header = [NSString stringWithFormat:@"Top Authors"];
            return header;
            break;

    }
    return header;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(12, 0, 320, 20);
    myLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:15];
    myLabel.textColor = [UIColor colorWithRed:10/255.0f green:99/255.0f blue:56/255.0f alpha:1.0];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:244/255.0f green:238/255.0f blue:230/255.0f alpha:1];
//    headerView.backgroundColor = [UIColor colorWithRed:74/255.0f green:144/255.0f blue:226/255.0f alpha:1.0];
    
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.topChartsArray == nil) {
        return 0.0;
    }
    return 190.0;
}

-(void)pushVC:(NSNotification *) notification {
    PP_MainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    NSIndexPath *indexpath = [notification.userInfo valueForKey:@"item"];
    NSNumber *sectionId = [notification.userInfo valueForKey:@"sectionId"];
    NSLog(@"%@",sectionId);
    
    if ([sectionId isEqualToNumber:@1]) {
        mainVC.textViewUrl = [[self.featuredArray objectAtIndex:indexpath.row]valueForKey:@"book_description"];
        mainVC.backgroundImageUrl = [[self.featuredArray objectAtIndex:indexpath.row]valueForKey:@"book_img_url"];
        mainVC.bookName = [[self.featuredArray objectAtIndex:indexpath.row]valueForKey:@"book_name"];
        
    } else {
        mainVC.textViewUrl = [[self.topChartsArray objectAtIndex:indexpath.row]valueForKey:@"book_description"];
        mainVC.backgroundImageUrl = [[self.topChartsArray objectAtIndex:indexpath.row]valueForKey:@"book_img_url"];
        mainVC.bookName = [[self.topChartsArray objectAtIndex:indexpath.row]valueForKey:@"book_name"];
    }
    
    [self.navigationController pushViewController:mainVC animated:YES];
}

#pragma mark - 
#pragma mark - Network Fetching

-(void)loadImagesInCollectionView {
    NSLog(@"------loadImagesInCollectionView--------");
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://pupus.web44.net/vinodrathod/pupus_get_image.php"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
            NSDictionary *returnedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"%@",returnedDictionary);
            
            for (int i=0; i<returnedDictionary.count; i++) {
                NSString *featuredUrl = [[returnedDictionary valueForKeyPath:@"featured"]objectAtIndex:i];
                NSLog(@"%@",featuredUrl);
                [self.featuredArray addObject:featuredUrl];
                [featured_imgs addObject:[[self.featuredArray objectAtIndex:i] valueForKey:@"book_img_url"]];
                
                NSString *topChartsUrl = [[returnedDictionary valueForKeyPath:@"topCharts"]objectAtIndex:i];
                [self.topChartsArray addObject:topChartsUrl];
                [topChart_imgs addObject:[[self.topChartsArray objectAtIndex:i]valueForKey:@"book_small_url"]];
            }
    
            NSLog(@"TopCharts Array: %@",self.topChartsArray);
            NSLog(@"Featured Array: %@",self.featuredArray);
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
    }];
    [task resume];
}


#pragma mark -
#pragma mark - Collection View Methods


@end
