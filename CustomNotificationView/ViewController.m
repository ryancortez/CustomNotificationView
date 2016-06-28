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

    // This the space that the user is able to grab for this view. (Since Apple's Notification Center drag from the top gesture overrides the gestures below it)
    CGFloat draggableHeightOfTheNotificationView = 44.0;


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NotificationView *notificationView = [self createNotificationView];
    [self animateFromTopWithNotificationView:notificationView];
}


#pragma mark - Helper Methods

// Shortens the View Controller's size call
- (CGSize) currentPartentViewSize {
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    CGSize viewSize = CGSizeMake(viewWidth, viewHeight);
    return  viewSize;
}


#pragma mark - Setting Up Notification View

// Create a customer NotificationView
- (NotificationView *) createNotificationView {
    CGSize parentViewSize = [self currentPartentViewSize];
    NotificationView *notificationView = [[NotificationView alloc]initWithSize:parentViewSize];
    [self addPanGestureRecognizerToNotificationView:notificationView];
    [self.view addSubview:notificationView];
    
    return notificationView;
}

// Make the NotificationView drag with the users finger at the bottom of the NotificationView
- (void) addPanGestureRecognizerToNotificationView: (NotificationView *) notificationView {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewDragged:)];
    [notificationView addGestureRecognizer:panGestureRecognizer];
}

// Make the NotificationView appear from the top by slowly animating in
- (void) animateFromTopWithNotificationView: (NotificationView *) notificationView{
    [UIView animateWithDuration:1.0 animations:^{
        [notificationView setFrame:CGRectMake(notificationView.frame.origin.x, (draggableHeightOfTheNotificationView * 2) - notificationView.frame.size.height, notificationView.frame.size.width, notificationView.frame.size.height)];
    }];
}


#pragma mark - Implementing Pan Gesture


// Implement behavior when the NotificationView is dragged
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
