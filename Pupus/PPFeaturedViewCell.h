//
//  PPFeaturedViewCell.h
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPFeaturedCellView.h"

@interface PPFeaturedViewCell : UITableViewCell

@property(nonatomic) PPFeaturedCellView *collectionView;
@property (nonatomic) NSArray *cellArray;
@end
