//
//  PPMainPageViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 02/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PPMainPageViewController.h"

@interface PPMainPageViewController ()<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
    UIView *mainView;
    CGPoint imagePosition;
}
@end

@implementation PPMainPageViewController

-(void)awakeFromNib {
    NSURL *imagesURL = [NSURL URLWithString:@"http://localhost/pupus/ImageSection.php"];
    NSData *jsonData = [NSData dataWithContentsOfURL:imagesURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:imagesURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            NSLog(@"%@", jsonDictionary);
            self.imagesArray = [NSMutableArray array];
            
            for (NSDictionary *dictionary in jsonDictionary) {
                NSString *url = [dictionary objectForKey:@"scanned_images"];
                [self.imagesArray addObject:url];
            }
            NSLog(@"%@",self.imagesArray);
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to load data. Connectivity Error!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    
    [task resume];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PupusBackground"]];

    self.scrollView.backgroundColor = [UIColor clearColor];

    self.mainCarouselView.type = iCarouselTypeCoverFlow2;
    self.mainCarouselView.backgroundColor = [UIColor clearColor];
    isFullScreen = false;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view insertSubview:blurView belowSubview:self.scrollView];
}

//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value;
//{
//
//}


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    NSLog(@"Array count is %lu",(unsigned long)self.imagesArray.count);
    return [self.imagesArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {
        
        FXImageView *carouselImageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/4)];
        carouselImageView.contentMode = UIViewContentModeScaleAspectFit;
        carouselImageView.asynchronous = YES;
        carouselImageView.reflectionScale = 0.5f;
        carouselImageView.reflectionAlpha = 0.25f;
        carouselImageView.reflectionGap = 10.0f;
        carouselImageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        carouselImageView.shadowBlur = 5.0f;
        view = carouselImageView;

    }
    
    NSLog(@"%@",[self.imagesArray objectAtIndex:index]);
    NSURL *urlOfImages = [NSURL URLWithString:[self.imagesArray objectAtIndex:index]];
    [(FXImageView *)view setImageWithContentsOfURL:urlOfImages];

    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Selected index %ld",(long)index);
    
//    mainView = [[UIView alloc]init];
//    mainView.frame = CGRectMake(0, self.topLayoutGuide.length, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-self.topLayoutGuide.length);
//    imagePosition = CGPointMake(mainView.center.x, mainView.center.y);
//    
//    if (!isFullScreen) {
//        [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
//            prevFrame = self.mainCarouselView.currentItemView.frame;
//            self.mainCarouselView.currentItemView.frame = mainView.frame;
//            self.mainCarouselView.currentItemView.center = imagePosition;
//        } completion:^(BOOL finished) {
//            isFullScreen = true;
//        }];
//        return;
//    } else {
//        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
//            self.mainCarouselView.currentItemView.frame = prevFrame;
//        } completion:^(BOOL finished) {
//            isFullScreen = false;
//        }];
//        return;
//    }
    
    mainView = [[UIView alloc]init];
    mainView.frame = CGRectMake(0, self.topLayoutGuide.length, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-self.topLayoutGuide.length);
    imagePosition = CGPointMake(mainView.center.x, mainView.center.y);
    CGPoint positin = CGPointMake(carousel.center.x, carousel.center.y);
    
    
    NSURL *selectedURL = [NSURL URLWithString:[self.imagesArray objectAtIndex:index]];
    NSData *selectedData = [NSData dataWithContentsOfURL:selectedURL];
    UIImage *selectedImage = [UIImage imageWithData:selectedData];
    UIImageView *bigImage = [[UIImageView alloc]init];
    bigImage.contentMode = UIViewContentModeScaleAspectFit;
    prevFrame = self.mainCarouselView.currentItemView.frame;
    
    bigImage.frame = prevFrame;
    bigImage.center = positin;
    bigImage.alpha = 0.0;
    [self.view addSubview:bigImage];
    
    
    if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            
            bigImage.frame = mainView.frame;
            bigImage.image = selectedImage;
            bigImage.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            isFullScreen = true;
        }];
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //            self.mainCarouselView.userInteractionEnabled = YES;
            
            bigImage.frame = prevFrame;
            bigImage.alpha = 0.0;
        } completion:^(BOOL finished) {
            isFullScreen = false;
        }];
        return;
    }

    
}



@end
