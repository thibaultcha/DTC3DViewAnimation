//
//  DTCViewController.m
//  DTCView3DAnimation
//
//  Created by Thibault Charbonnier & Thomas Ricouard on 10/05/13.
//  Copyright (c) 2013 thibaultCha & Dimillian. All rights reserved.
//

const CGFloat kAnimDuration = 0.2f;
const CGFloat kScale = 0.8f;

#import "DTCViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DTCViewController ()

@end

@implementation DTCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIlabel
    CGRect labelFrame = CGRectMake(0, 60.0f, 0, 0);
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"This is a cool animation";
    [label sizeToFit];
    labelFrame.origin.x = self.view.center.x - label.frame.size.width / 2;
    [label setFrame:labelFrame];
    [label sizeToFit];
    [self.view addSubview:label];
    
    // Gesture
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(onPanGesture:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPanGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint position = [gesture locationInView:self.view.window];
    
    if ( UIGestureRecognizerStateBegan == gesture.state ) {
        [UIView animateWithDuration:kAnimDuration animations:^{
            // Old stuff to zoom out
            //self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScale, kScale);
            TransformAnimation(position, self.view, 20.0f);
        
        }];
    }
    else if ( UIGestureRecognizerStateChanged == gesture.state ) {
        
        TransformAnimation(position, self.view, 20.0f);
        
    }
    else if ( UIGestureRecognizerStateEnded == gesture.state ) {
        [UIView animateWithDuration:kAnimDuration animations:^{
            
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        
        }];
    }
}

// Block declaration
void (^TransformAnimation)(CGPoint position, UIView *view, CGFloat maxAngle) = ^(CGPoint position, UIView *view, CGFloat maxAngle)
{
    CGPoint center = view.center;
    CGFloat dx = position.x - center.x;
    CGFloat dy = position.y - center.y;
    // Get values for x and y between 1 and -1
    CGFloat yTransformation = dx / view.window.frame.size.width;
    CGFloat xTransformation = -dy / view.window.frame.size.height;
    // Calculate the angle
    CGFloat maxX = view.window.frame.size.width - center.x;
    CGFloat maxY = view.window.frame.size.height - center.y;
    CGFloat angle = (sqrt(dx*dx + dy*dy) / sqrt(maxX*maxX + maxY*maxY)) * maxAngle;
    
#ifdef DEBUG
    //NSLog(@"%f %f", xTransformation, yTransformation);
    //NSLog(@"distance %f", sqrt(dx*dx + dy*dy));
    //NSLog(@"angle %f", angle);
#endif
    
    // Begin the transformation anim
    CATransform3D layerTransform = CATransform3DIdentity;
    layerTransform.m34 = 1.0f / -300; // perspective effect
    view.layer.transform = CATransform3DRotate(layerTransform,
                                               angle / (180.0f / M_PI),
                                               xTransformation,
                                               yTransformation,
                                               0);
};



@end
