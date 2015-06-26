//
//  MainView.h
//  SF-Gesture
//
//  Created by kenneth on 6/24/15.
//  Copyright (c) 2015 kenneth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageViewDelegate <NSObject>

- (void) viewDisappearToLeft;
- (void) viewDisappearToRight;
- (void) centerOfViewChangedToNewPoint:(CGPoint)newCenter;
- (void) viewIsMoving:(double)distance;
- (void) movingCancelled;

@end


@interface ImageView : UIView

@property (nonatomic,assign) id<ImageViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andImage:(NSString *)imageName;
@end
