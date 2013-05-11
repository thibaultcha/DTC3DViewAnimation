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
@property (weak, nonatomic) IBOutlet UISlider *maxAngle;
@property (weak, nonatomic) IBOutlet UILabel *angleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)onAngleValueChanged:(id)sender;
- (void)onPanGesture:(UIPanGestureRecognizer *)gesture;

@end
