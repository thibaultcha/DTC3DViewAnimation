## DTC3DViewAnimation

This animation "push" a view according to a point (x and y) and relative to it's center.

[Video demo](http://cl.ly/323y3i0C3s2c)

![](screenshot1.png)

## How
It's this block doing the trick:

```objective-c
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
    
    // Begin the transformation anim
    CATransform3D layerTransform = CATransform3DIdentity;
    layerTransform.m34 = 1.0f / -300; // perspective effect
    view.layer.transform = CATransform3DRotate(layerTransform,
                                               angle / (180.0f / M_PI),
                                               xTransformation,
                                               yTransformation,
                                               0);
};
```

Made with the help of [@Dimillian](https://github.com/Dimillian).

## Licence
```
Copyright (C) 2013 Thibault Charbonnier & Thomas Ricouard.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
