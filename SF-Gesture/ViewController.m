//
//  ViewController.m
//  SF-Gesture
//
//  Created by kenneth on 6/24/15.
//  Copyright (c) 2015 kenneth. All rights reserved.
//

#import "ViewController.h"
#import "ImageView.h"
#import "ImagesScrollView.h"

@interface ViewController (){
    ImageView *mv;
    CGRect frameOfMainView;
    ImagesScrollView *imgScrollView;
    
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    frameOfMainView = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    imgScrollView = [[ImagesScrollView alloc] initWithFrame:frameOfMainView];
    [imgScrollView loadThreeImageView];
    [self.view addSubview:imgScrollView];

    
}

- (void)resetMainView
{
    imgScrollView.frame = frameOfMainView;
    imgScrollView.backgroundColor = [UIColor greenColor];
    NSLog(@"----");
}



@end
