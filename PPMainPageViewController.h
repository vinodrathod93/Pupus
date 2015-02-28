//
//  PPMainPageViewController.h
//  Pupus
//
//  Created by Vinod Rathod on 02/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "FXImageView.h"

@interface PPMainPageViewController : UIViewController

@property (weak, nonatomic) IBOutlet iCarousel *mainCarouselView;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CS_CarouselView_Height;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
