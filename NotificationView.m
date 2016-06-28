//
//  NotificationView.m
//  CustomNotificationView
//
//  Created by Ryan Cortez on 6/27/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "NotificationView.h"

@implementation NotificationView

- (instancetype) initWithSize: (CGSize) size {
    
    self = [super initWithFrame:CGRectMake(0.0, -(size.height), size.width, size.height)];
    [self roundBottomCorners];
    [self blurViewBackground];
    [self createGripBar:size];
    
    return self;
}

// Create a bar at the bottonm of the NotficationView that signals that the user should be able to drag the view
- (void) createGripBar: (CGSize) size {
    CGFloat gripDistanceFromBottomEdge = 30.0;
    CGFloat gripWidth = 50;
    CGFloat gripHeight = 10;
    
    UIVisualEffectView *gripBar = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(self.center.x - (gripWidth / 2), size.height - gripDistanceFromBottomEdge, gripWidth, gripHeight)];
    gripBar.layer.cornerRadius = 6.0;
    gripBar.layer.masksToBounds = YES;
    gripBar.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    [self addSubview:gripBar];
}

// Round the bottom corners of the Notification View
- (void) roundBottomCorners {
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){15.0, 15.}].CGPath;
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
}

- (void) blurViewBackground {
    self.backgroundColor = [UIColor clearColor];
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
}

@end
