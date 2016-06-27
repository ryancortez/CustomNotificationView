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
    CGFloat originY = -(size.height);
    CGFloat originX = 0.0;
    self = [super initWithFrame:CGRectMake(originX, originY, size.width, size.height)];
    
    CGFloat gripDistanceFromBottomEdge = 30.0;
    CGFloat gripWidth = 50;
    CGFloat gripHeight = 10;
    
    UIView *gripBar = [[UIView alloc]initWithFrame:CGRectMake(self.center.x - (gripWidth / 2), size.height - gripDistanceFromBottomEdge, gripWidth, gripHeight)];
    gripBar.backgroundColor = [UIColor blackColor];
    gripBar.layer.cornerRadius = 6.0;
    
    [self addSubview:gripBar];
    
    return self;
}

@end
