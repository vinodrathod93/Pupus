//
//  PP_MainViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 11/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PP_MainViewController.h"


@interface PP_MainViewController ()
{
    UITextView *customView;
    UIImageView *searchedImageView;
    UIImageView *authorImageView;
}
@property (nonatomic) NSMutableArray *imagesArray;
@property (nonatomic) NSMutableArray *textViewArray;
@end

@implementation PP_MainViewController


-(void)awakeFromNib {

    UIImage *tabImage = [[UIImage imageNamed:@"What.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarController.tabBar setBackgroundImage:[[UIImage imageNamed:@"Tabbar_background"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self.tabBarController.tabBar setBackgroundColor:[UIColor clearColor]];
    self.tabBarItem.title = nil;
    self.tabBarItem.image = tabImage;
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Selected_What3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                      [UIFont fontWithName:@"ProximaNova-Regular" size:22], NSFontAttributeName, nil];
    [self loadDataWithPath:@"http://localhost/pupus/ImageSection.php" forKey:@"scanned_images"];

    [self loadTextViewDataWithPath:@"http://localhost/pupus/text_data/textview_data.txt" forKey:nil];
}

-(void)loadDataWithPath:(NSString *)URLString forKey:(NSString *)key {
    
    NSURL *imagesURL = [NSURL URLWithString:URLString];
    NSData *data = [NSData dataWithContentsOfURL:imagesURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:imagesURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"%@", jsonDictionary);
            self.imagesArray = [NSMutableArray array];
            
            for (NSDictionary *dictionary in jsonDictionary) {
                NSString *url = [dictionary objectForKey:key];
                [self.imagesArray addObject:url];
            }
            NSLog(@"Insides Data%@",self.imagesArray);
            
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Unable to load data. Connectivity Error!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    
    [task resume];
    
}


-(void)loadTextViewDataWithPath:(NSString *)URLString forKey:(NSString *)key {
    NSURL *URL = [NSURL URLWithString:URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error == nil) {
//            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSLog(@"%@", jsonDictionary);
//            self.textViewArray = [NSMutableArray array];
//            
//            for (NSDictionary *dictionary in jsonDictionary) {
//                NSString *url = [dictionary objectForKey:key];
//                [self.textViewArray addObject:url];
//            }
//            NSLog(@"Insides Data%@",self.textViewArray);
            
            NSString *strings = [[NSString alloc]initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strings);
            self.textViewArray = [NSMutableArray array];
            [self.textViewArray addObject:strings];
            NSLog(@"%@",self.textViewArray[0]);
            
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
    
    _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _foregroundContentView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:[self blurEffect]]];
    
    _backgroundView = [[UIVisualEffectView alloc]initWithEffect:[self blurEffect]];
//    _foregroundContentScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _contentView = [[UIView alloc]initWithFrame:self.view.frame];
    
//    _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:_blurEffect];
//    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.contentView insertSubview:blurView atIndex:0];
//    
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:_blurEffect];
//    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
//    [vibrancyView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [vibrancyView.contentView addSubview:_foregroundContentScrollView];
    
        [self configureViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    searchedImageView.frame = CGRectMake(0, self.topLayoutGuide.length+5.0f, self.view.frame.size.width, self.view.frame.size.height/3.0f);
    
    customView.frame = CGRectMake(0, self.topLayoutGuide.length+self.view.frame.size.height/3.0f + 10.0f, self.view.bounds.size.width, ceilf(self.view.bounds.size.height-self.topLayoutGuide.length-self.bottomLayoutGuide.length-searchedImageView.frame.size.height-10.0f));
}

#pragma mark - Configuring Views

-(void)configureViews {
    
    // Status Bar style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Loading Background Images from Server
    [[self view] setBackgroundColor:[UIColor clearColor]];
    NSUInteger randomNumber = arc4random_uniform(self.imagesArray.count);
    NSLog(@"Random Number %@",self.imagesArray[randomNumber]);
    NSURL *url = [NSURL URLWithString:self.imagesArray[randomNumber]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    [[self backgroundImageView] setImage:[UIImage imageWithData:imageData]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // Used for setting constraints for programmatically created views.
    [[self backgroundView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self overlayView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self foregroundContentView] setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    customView = [[UITextView alloc]init];
    customView.font = [UIFont fontWithName:@"ProximaNova-Light" size:18];
    customView.textContainerInset = UIEdgeInsetsMake(10, 15, 0, 15);
    customView.textAlignment = NSTextAlignmentLeft;
    customView.textColor = [UIColor colorWithRed:229/255.0f green:226/255.0f blue:225/255.0f alpha:1.0];
//    customView.textColor = [UIColor blackColor];
    customView.editable = NO;
    customView.backgroundColor = [UIColor clearColor];
    customView.text = [NSString stringWithFormat:@"%@",self.textViewArray[0]];
    customView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    searchedImageView = [[UIImageView alloc]init];
    [searchedImageView setImage:[UIImage imageWithData:imageData]];
    searchedImageView.contentMode = UIViewContentModeScaleAspectFit;
    searchedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.overlayView addSubview:self.backgroundView];
    [self.overlayView addSubview:self.contentView];
    
    [self.contentView addSubview:self.foregroundContentView];
    [self.foregroundContentView addSubview:customView];
    [self.foregroundContentView addSubview:searchedImageView];
    
    
    // Setting Label2 constrainst to CenterX
//    NSLayoutConstraint *label2_constraints = [NSLayoutConstraint constraintWithItem:customView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.overlayView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
//    [self.overlayView addConstraint:label2_constraints];
    
    
    
    
    NSDictionary *views = @{
                            @"backgroundView": self.backgroundView,
                            @"ScrollView": self.contentView,
                            @"foregroundContentView": self.foregroundContentView,
                            @"imageView": searchedImageView,
                            @"textView": customView
                            };
    
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|" options:0 metrics:nil views:views]];
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|" options:0 metrics:nil views:views]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ScrollView]|" options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ScrollView]|" options:0 metrics:nil views:views]];
    
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[foregroundContentView]|" options:0 metrics:nil views:views]];
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[foregroundContentView]|" options:0 metrics:nil views:views]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-|" options:0 metrics:nil views:views]];
//    [self.foregroundContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0 metrics:nil views:views]];
//
//    
//    [self.foregroundContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-[textView]-(>=10)-|" options:0 metrics:nil views:views]];
    
    
}




@end
