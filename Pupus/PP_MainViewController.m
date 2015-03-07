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
    UITextView *textView;
    UIImageView *searchedImageView;
    UIImageView *authorImageView;
}
@property (nonatomic) NSMutableArray *imagesArray;
@property (nonatomic) NSMutableArray *textViewArray;
@end

@implementation PP_MainViewController


-(void)awakeFromNib {

    /*
    UIImage *tabImage = [[UIImage imageNamed:@"What.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarController.tabBar setBackgroundImage:[[UIImage imageNamed:@"Tabbar_background"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self.tabBarController.tabBar setBackgroundColor:[UIColor clearColor]];
    self.tabBarItem.title = nil;
    self.tabBarItem.image = tabImage;
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Selected_What3.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     */
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:10/255.0f green:99/255.0f blue:56/255.0f alpha:1.0], NSForegroundColorAttributeName,
                                      [UIFont fontWithName:@"ProximaNova-Regular" size:22], NSFontAttributeName, nil];
    
    
    [self loadTextViewDataWithPath:@"http://localhost/pupus/text_data/textview_data.txt" forKey:nil];
    
    [self loadDataWithPath:@"http://localhost/pupus/ImageSection.php" forKey:@"scanned_images"];

    
}

-(void)loadDataWithPath:(NSString *)URLString forKey:(NSString *)key {
    
    NSURL *imagesURL = [NSURL URLWithString:URLString];
    NSData *data = [NSData dataWithContentsOfURL:imagesURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:imagesURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"%@", jsonDictionary);
            if (!self.imagesArray) {
                self.imagesArray = [NSMutableArray array];
            }
            
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
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            
            NSString *strings = [[NSString alloc]initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSLog(@"%@",strings);
            if (!self.textViewArray) {
                self.textViewArray = [NSMutableArray array];
            }
            
            [self.textViewArray addObject:strings];
            NSLog(@"%@",self.textViewArray[0]);
        }
    
    }];
    
    [task resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _foregroundContentView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:[self blurEffect]]];
    
    _backgroundView = [[UIVisualEffectView alloc]initWithEffect:[self blurEffect]];
    _contentView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self configureViews];
    // Do any additional setup after loading the view.
}


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    searchedImageView.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height/3.0f-10.0f);
    textView.frame = CGRectMake(0, self.view.bounds.size.height/3.0f, self.view.bounds.size.width, self.view.bounds.size.height-self.view.bounds.size.height/3.0f-self.topLayoutGuide.length-10);
}

#pragma mark - Configuring Views

-(void)configureViews {
    
    // Status Bar style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Loading Background Images from Server
    [[self view] setBackgroundColor:[UIColor clearColor]];
    int number = (int)self.imagesArray.count;
    NSUInteger randomNumber = arc4random_uniform(number);
    NSLog(@"Random Number %lu",(unsigned long)randomNumber);
    NSURL *url = [NSURL URLWithString:self.imagesArray[randomNumber]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    [[self backgroundImageView] setImage:[UIImage imageWithData:imageData]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // Used for setting constraints for programmatically created views.
    [[self backgroundView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self overlayView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self foregroundContentView] setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    searchedImageView = [[UIImageView alloc]init];
    searchedImageView.image = [UIImage imageWithData:imageData];
    [self.foregroundContentView addSubview:searchedImageView];
    
    textView = [[UITextView alloc]init];
    textView.font = [UIFont fontWithName:@"ProximaNova-Light" size:18];
    textView.textContainerInset = UIEdgeInsetsMake(10, 15, 0, 15);
    textView.textAlignment = NSTextAlignmentLeft;
    textView.textColor = [UIColor colorWithRed:229/255.0f green:226/255.0f blue:225/255.0f alpha:1.0];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = [NSString stringWithFormat:@"%@",self.textViewArray[0]];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.overlayView addSubview:self.backgroundView];
    [self.overlayView addSubview:self.contentView];
    
    [self.contentView addSubview:self.foregroundContentView];
    [self.foregroundContentView addSubview:textView];
    
    
    NSDictionary *views = @{
                            @"backgroundView": self.backgroundView,
                            @"ScrollView": self.contentView,
                            @"foregroundContentView": self.foregroundContentView,
                            @"textView": textView
                            };
    
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundView]|" options:0 metrics:nil views:views]];
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundView]|" options:0 metrics:nil views:views]];
    
    
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[foregroundContentView]|" options:0 metrics:nil views:views]];
    [self.overlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[foregroundContentView]|" options:0 metrics:nil views:views]];
    
    
}




@end
