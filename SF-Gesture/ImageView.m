//
//  MainView.m
//  SF-Gesture
//
//  Created by kenneth on 6/24/15.
//  Copyright (c) 2015 kenneth. All rights reserved.
//

#import "ImageView.h"

@interface ImageView (){
    
    UILabel *label;
    CGPoint centerOfScreen;
    CGPoint pointA;
    CGPoint originCenterOfMainView;
    BOOL recorded;
    UIPanGestureRecognizer *panGesture;
    
    
    UIImageView *imgView;
}

@end

@implementation ImageView


- (id)initWithFrame:(CGRect)frame andImage:(NSString *)imageName
{
    if (self = [super init])
    {
        recorded = NO;
        self.bounds = frame;
        UIView *backGroundView = [[UIView alloc] initWithFrame:frame];
        backGroundView.backgroundColor = [UIColor grayColor];
        [self addSubview:backGroundView];
        
        
        imgView = [[UIImageView alloc] initWithFrame:backGroundView.bounds];
        [imgView setImage:[UIImage imageNamed:imageName]];
        imgView.backgroundColor = [UIColor redColor];
        [backGroundView addSubview:imgView];
        
        panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeWithPanGesture:)];
        [self addGestureRecognizer:panGesture];
        
        centerOfScreen = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - 10);
    }
    
    
    return  self;
}

- (void) swipeWithPanGesture:(UIGestureRecognizer *)sender
{

    if (sender.state == UIGestureRecognizerStateBegan)
    {
        pointA = [sender locationInView:self.superview];
        originCenterOfMainView = self.center;
        NSLog(@"%f - %f",pointA.x, pointA.y);
                NSLog(@"Started");
    } else if (sender.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"Cancelled");
    } else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint temPoint = [sender locationInView:self.superview];
        double disX = fabs(temPoint.x - pointA.x);
        double disY = fabs(temPoint.y - pointA.y);
        if (disX > 5) {
            [panGesture addTarget:self action:@selector(movehorizontally:)];
            [panGesture removeTarget:self action:@selector(swipeWithPanGesture:)];
            [panGesture removeTarget:self action:@selector(moveVertically:)];
            
        } else if (disY > 5) {
//            [panGesture addTarget:self action:@selector(moveVertically:)];
//            [panGesture removeTarget:self action:@selector(swipeWithPanGesture:)];
//            [panGesture removeTarget:self action:@selector(movehorizontally:)];
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Ended");

    } else{
        NSLog(@"Other Else");
    }
}


- (void) movehorizontally:(UIGestureRecognizer *)sender
{
//    NSLog(@"movehorizontally");
    if (sender.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"Cancelled");
    } else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint temPoint = [sender locationInView:self.superview];
        double distance = (temPoint.x - pointA.x);
        self.center = CGPointMake(originCenterOfMainView.x + distance, originCenterOfMainView.y);
        if ([_delegate respondsToSelector:@selector(viewIsMoving:)])
        {
            [_delegate viewIsMoving:distance];
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint temPoint = [sender locationInView:self.superview];
        double distance = (temPoint.x - pointA.x);
        
        if (distance > self.frame.size.width / 4) {
            if ([_delegate respondsToSelector:@selector(viewDisappearToRight)])
            {
                [_delegate viewDisappearToRight];
            }
        } else if (distance < -(self.frame.size.width / 4))
        {
            if ([_delegate respondsToSelector:@selector(viewDisappearToLeft)])
            {
                [_delegate viewDisappearToLeft];
            }
        } else
        {
//            [UIView animateWithDuration:0.2 animations:^{
//                self.center = centerOfScreen;
//            } completion:^(BOOL finished) {
//                NSLog(@"Finished");
//            }];
            if ([_delegate respondsToSelector:@selector(movingCancelled)])
            {
                [_delegate movingCancelled];
            }
        }
        
        
        
        
        
        [panGesture addTarget:self action:@selector(swipeWithPanGesture:)];
        [panGesture removeTarget:self action:@selector(movehorizontally:)];
        NSLog(@"Back to original");
        
        
        
        
    } else{
        NSLog(@"Other Else");
    }

}

- (void) moveVertically:(UIGestureRecognizer *)sender
{
    NSLog(@"moveVertically");
    if (sender.state == UIGestureRecognizerStateCancelled)
    {
        NSLog(@"Cancelled");
    } else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint temPoint = [sender locationInView:self.superview];
        double distance = (temPoint.y - pointA.y);
        
        
        self.center = CGPointMake(originCenterOfMainView.x, originCenterOfMainView.y  + distance);
        NSLog(@"%f - %f",temPoint.x, temPoint.y);
        
        
    } else if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Ended");
        NSLog(@"Back to original");
        [panGesture addTarget:self action:@selector(swipeWithPanGesture:)];
        [panGesture removeTarget:self action:@selector(movehorizontally:)];
        
        
        
    } else{
        NSLog(@"Other Else");
    }
}


@end
