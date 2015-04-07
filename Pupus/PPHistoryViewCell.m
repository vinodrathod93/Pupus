//
//  PPHistoryViewCell.m
//  Pupus
//
//  Created by Vinod Rathod on 28/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PPHistoryViewCell.h"

@implementation PPHistoryViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:18];
    self.titleLabel.textColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor colorWithRed:245/255.0f green:166/255.0f blue:35/255.0f alpha:0.87];
    self.backgroundColor = [UIColor grayColor];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://localhost/pupus/images/books/tolstoy-war-and-peace-bookcover.jpg"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bookImageView.image = [UIImage imageWithData:data];
        });
        
    });
}



@end
