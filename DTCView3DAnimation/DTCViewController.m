//
//  DTCViewController.m
//  DTCView3DAnimation
//
//  Created by Thibault Charbonnier & Thomas Ricouard on 10/05/13.
//  Copyright (c) 2013 thibaultCha & Dimillian. All rights reserved.
//

const CGFloat kAnimDuration = 0.2f;

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
    
    // Gesture
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(onPanGesture:)];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self setAngleLabel:nil];
    [self setMaxAngle:nil];
}


#pragma mark - Slider value changed


- (IBAction)onAngleValueChanged:(id)sender
{
    self.angleLabel.text = [NSString stringWithFormat:@"%.0f°", ((UISlider*)sender).value];
}


#pragma mark - Pan gesture


- (void)onPanGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint position = [gesture locationInView:self.view.window];
    
    if ( UIGestureRecognizerStateBegan == gesture.state ) {
        [UIView animateWithDuration:kAnimDuration animations:^{
            // Old stuff to zoom out
            //self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScale, kScale);
            TransformAnimation(position, self.view, self.maxAngle.value);
        
        }];
    }
    else if ( UIGestureRecognizerStateChanged == gesture.state ) {
        
        TransformAnimation(position, self.view, self.maxAngle.value);
        
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
    CGFloat dx = position.x - view.center.x;
    CGFloat dy = position.y - view.center.y;
    // Get values for x and y axis
    CGFloat yTransformation = dx / view.window.frame.size.width;
    CGFloat xTransformation = -dy / view.window.frame.size.height;
    // Calculate the angle depending on the distance from the center
    CGFloat maxX = view.window.frame.size.width - view.center.x;
    CGFloat maxY = view.window.frame.size.height - view.center.y;
    CGFloat angle = (sqrt(dx*dx + dy*dy) / sqrt(maxX*maxX + maxY*maxY)) * maxAngle;
    
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
