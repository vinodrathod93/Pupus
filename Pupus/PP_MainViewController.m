//
//  PP_MainViewController.m
//  Pupus
//
//  Created by Vinod Rathod on 11/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PP_MainViewController.h"
#import "AppDelegate.h"


@interface PP_MainViewController ()
{
    UITextView *textView;
    UIImageView *searchedImageView;
    UIImageView *authorImageView;
    UIImage *image;
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
    
    

    
}


-(void)loadDataWithPath:(NSString *)URLString forKey:(NSString *)key {
    NSLog(@"Images =======> %@",URLString);
    NSURL *imagesURL = [NSURL URLWithString:URLString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:imagesURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            image = [UIImage imageWithData:data];
            [self.imagesArray addObject:image];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.backgroundImageView.image = image;
        });
    }];
    [task resume];
    
//    [AppDelegate downloadDataFromURL:imagesURL withCompletionHandler:^(NSData *data) {
//        NSError *error;
//        if (error == nil) {
//            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//            NSLog(@"%@", jsonDictionary);
//            if (!self.imagesArray) {
//                self.imagesArray = [NSMutableArray array];
//            }
//            
//            for (NSDictionary *dictionary in jsonDictionary) {
//                NSString *url = [dictionary objectForKey:key];
//                [self.imagesArray addObject:url];
//            }
//            NSLog(@"Insides Data%@",self.imagesArray);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ImagesArrayFilled" object:nil];
//            
//        }
//    }];
    
}



-(void)loadTextViewDataWithPath:(NSString *)URLString forKey:(NSString *)key {
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSString *strings = [[NSString alloc]initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
            NSLog(@"String value is =============>%@",strings);
            if (!self.textViewArray) {
                self.textViewArray = [NSMutableArray array];
            }
            
            [self.textViewArray addObject:strings];
            NSLog(@"%@",self.textViewArray[0]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureViews:nil];
        });
        
    }];
    
    [task resume];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationController *navCon  = (UINavigationController*) [self.navigationController.viewControllers objectAtIndex:1];
    navCon.navigationItem.title = self.bookName;
    
//    [self loadDataWithPath:@"http://localhost/pupus/ImageSection.php" forKey:@"scanned_images"];
    
    _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _foregroundContentView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:[self blurEffect]]];
    
    _backgroundView = [[UIVisualEffectView alloc]initWithEffect:[self blurEffect]];
    _contentView = [[UIView alloc]initWithFrame:self.view.frame];
    
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"ViewDidAppear");
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"ViewWillAppear");
    
    [self loadTextViewDataWithPath:self.textViewUrl forKey:nil];
    [self loadDataWithPath:self.backgroundImageUrl forKey:nil];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    searchedImageView.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height/3.0f-10.0f);
    textView.frame = CGRectMake(0, self.view.bounds.size.height/3.0f, self.view.bounds.size.width, self.view.bounds.size.height-self.view.bounds.size.height/3.0f-self.topLayoutGuide.length-10);
}

#pragma mark - Configuring Views

-(void)configureViews:(NSNotification *)notification {
    
    // Status Bar style
    
    
    
    // Loading Background Images from Server
    [[self view] setBackgroundColor:[UIColor clearColor]];
    
//    int number = (int)self.imagesArray.count;
//    NSUInteger randomNumber = arc4random_uniform(number);
//    NSLog(@"Random Number %lu",(unsigned long)randomNumber);
//    NSURL *url = [NSURL URLWithString:self.imagesArray[randomNumber]];
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
    [[self backgroundImageView] setImage:image];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // Used for setting constraints for programmatically created views.
    [[self backgroundView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self overlayView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self foregroundContentView] setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    searchedImageView = [[UIImageView alloc]init];
//    searchedImageView.image = [UIImage imageWithData:imageData];
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




- (IBAction)backVC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
