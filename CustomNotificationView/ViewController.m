//
//  ViewController.m
//  CustomNotificationView
//
//  Created by Ryan Cortez on 6/27/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

    CGFloat draggableHeightOfTheNotificationView = 44.0;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    CGSize viewSize = CGSizeMake(viewWidth, viewHeight);
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    NotificationView *notificationView = [[NotificationView alloc]initWithSize:viewSize];
    notificationView.effect = blurEffect;
    notificationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:notificationView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewDragged:)];
    
    [notificationView addGestureRecognizer:panGestureRecognizer];
    
    [UIView animateWithDuration:1.0 animations:^{
        [notificationView setFrame:CGRectMake(notificationView.frame.origin.x, (draggableHeightOfTheNotificationView * 2) - notificationView.frame.size.height, notificationView.frame.size.width, notificationView.frame.size.height)];
    }];
}

- (void) viewDragged: (UIPanGestureRecognizer *) gestureRecognizer {
    
    CGRect viewFrame = gestureRecognizer.view.frame;
    CGPoint locationOfTouch = [gestureRecognizer locationInView:self.view];
    
    // Let the user's finger match with the bottom of the NotificationView
    [gestureRecognizer.view setFrame:CGRectMake(viewFrame.origin.x, locationOfTouch.y + draggableHeightOfTheNotificationView - viewFrame.size.height, viewFrame.size.width, viewFrame.size.height)];
    
    // If the NotificationView is being dragged too high, make sure you leave a draggable area so that the user can drag it later
    if (locationOfTouch.y  >= self.view.frame.size.height - draggableHeightOfTheNotificationView) {
        [gestureRecognizer.view setFrame:CGRectMake(viewFrame.origin.x, 0, viewFrame.size.width, viewFrame.size.height)];
    }
    
    // If the NotificationView will go to far below the screen keep it resting at the bottom of the screen
    if (locationOfTouch.y <= draggableHeightOfTheNotificationView) {
        [gestureRecognizer.view setFrame:CGRectMake(viewFrame.origin.x, draggableHeightOfTheNotificationView * 2 - self.view.frame.size.height, viewFrame.size.width, viewFrame.size.height)];
    }
}



@end
