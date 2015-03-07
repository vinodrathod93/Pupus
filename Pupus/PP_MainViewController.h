//
//  PP_MainViewController.h
//  Pupus
//
//  Created by Vinod Rathod on 11/01/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PP_MainViewController : UIViewController
@property (nonatomic) UIView *contentView;
@property (nonatomic) IBOutlet UIScrollView *foregroundContentScrollView;
@property (nonatomic) UIVisualEffectView *backgroundView;
@property (nonatomic) UIVisualEffectView *foregroundContentView;
@property (nonatomic) UIBlurEffect *blurEffect;
//@property (nonatomic) UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
