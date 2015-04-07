//
//  HomeViewController.h
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol passArrays<NSObject>
//
//-(void)setFeaturedArray:(NSArray *)array;
//-(void)setTopChartsArray:(NSArray *)array;
//
//@end

@interface HomeViewController : UITableViewController


//@property (nonatomic, retain)id <passArrays> delegate;

@property (strong, nonatomic) NSMutableArray *featuredArray;
@property (strong, nonatomic) NSMutableArray *topChartsArray;


@end
