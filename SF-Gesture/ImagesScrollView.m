//
//  ImagesScrollView.m
//  SF-Gesture
//
//  Created by kenneth on 6/25/15.
//  Copyright (c) 2015 kenneth. All rights reserved.
//

#import "ImagesScrollView.h"
#import "ImageView.h"

@interface ImagesScrollView () {
    
    ImageView *imageView0;
    ImageView *imageView1;
    ImageView *imageView2;
    CGPoint originalCenterForView0;
    CGPoint originalCenterForView1;
    CGPoint originalCenterForView2;
    BOOL isMovingToRight;
    
}

@end

@implementation ImagesScrollView

 -(void) loadThreeImageView
{
    CGRect frameOfMainView = self.bounds;
    imageView1 = [[ImageView alloc] initWithFrame:frameOfMainView andImage:@"001.png"];//WithFrame:CGRectMake(25, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 25)];
    imageView1.frame = frameOfMainView;//CGRectMake(25, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 25);
    imageView1.backgroundColor = [UIColor greenColor];
    originalCenterForView1 = imageView1.center;
    [self addSubview:imageView1];
    imageView1.delegate = self;
    
    imageView0 = [[ImageView alloc] initWithFrame:frameOfMainView andImage:@"002.png"];//WithFrame:CGRectMake(25, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 25)];
    imageView0.frame = frameOfMainView;//CGRectMake(25, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height / 2 - 25);
    originalCenterForView0 = CGPointMake(-2 * imageView1.center.x / 5 , imageView1.center.y);
    originalCenterForView2 = CGPointMake(3 * imageView1.center.x , imageView1.center.y);
    imageView0.center = originalCenterForView2;
    imageView0.backgroundColor = [UIColor greenColor];
    [self addSubview:imageView0];
    [self bringSubviewToFront:imageView1];
    
}

- (void)viewDisappearToLeft{
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView1.center = CGPointMake(-originalCenterForView1.x, originalCenterForView1.y);
        imageView0.center = originalCenterForView1;
    } completion:^(BOOL finished) {
        [imageView1 removeFromSuperview];
        imageView1 = imageView0;
        imageView1.delegate = self;
        imageView0 = nil;
        int i = arc4random()%9 + 1;
        NSString *imgName = [NSString stringWithFormat:@"00%d.png",i];
        imageView0 = [[ImageView alloc] initWithFrame:self.bounds andImage:imgName];
//        imageView0.center = originalCenterForView2;
        [self addSubview:imageView0];
        [self bringSubviewToFront:imageView1];
        
    }];
    NSLog(@"viewDisappearToLeft");
}

- (void)viewDisappearToRight
{
    [UIView animateWithDuration:0.3 animations:^{
        imageView1.center = CGPointMake(originalCenterForView1.x * 3, originalCenterForView1.y);
        imageView0.center = originalCenterForView1;
    } completion:^(BOOL finished) {
        [imageView1 removeFromSuperview];
        imageView1 = imageView0;
        imageView1.delegate = self;
        imageView0 = nil;
        int i = arc4random()%9 + 1;
        NSString *imgName = [NSString stringWithFormat:@"00%d.png",i];
        imageView0 = [[ImageView alloc] initWithFrame:self.bounds andImage:imgName];
//        imageView0.center = originalCenterForView0;
        [self addSubview:imageView0];
        [self bringSubviewToFront:imageView1];
        
    }];
    NSLog(@"viewDisappearToRight");
}


- (void) viewIsMoving:(double)distance
{

    if (imageView1.frame.origin.x >= 0)
    {
        [self bringSubviewToFront:imageView1];
        double distanceForView0 = 7 * distance / 10;
        imageView0.center = CGPointMake(originalCenterForView0.x + distanceForView0, originalCenterForView0.y);
        
    } else
    {
        [self bringSubviewToFront:imageView0];
        double distanceForView0 = 13 * distance / 10;
        imageView0.center = CGPointMake(originalCenterForView2.x + distanceForView0, originalCenterForView0.y);
    }
    
}

- (void)movingCancelled
{
    [UIView animateWithDuration:0.3 animations:^{
        imageView0.center = (imageView1.frame.origin.x >= 0) ? originalCenterForView0 : originalCenterForView2;
        imageView1.center = originalCenterForView1;
    }];

}



@end
