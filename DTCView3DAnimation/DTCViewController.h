//
//  DTCViewController.m
//  DTCView3DAnimation
//
//  Created by Thibault Charbonnier & Thomas Ricouard on 10/05/13.
//  Copyright (c) 2013 thibaultCha & Dimillian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTCViewController : UIViewController

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

- (void)onPanGesture:(UIPanGestureRecognizer *)gesture;

@end
