//
//  FaceView.m
//  Happiness
//
//  Created by Thadeu Carmo on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

#define DEFAULT_SCALE 0.9

- (void) setScale:(CGFloat)scale
{
    if(scale != _scale)
    {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (CGFloat) scale
{
    if(!_scale)
    {
        return DEFAULT_SCALE;
    }
    return _scale;
}

- (void) pinch: (UIPinchGestureRecognizer *) gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.scale *= gesture.scale;
        // reset the gesture scale to have incremental values instead of cumulative values
        gesture.scale = 1.0;
    }
}

- (void) setup 
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat) radius inContext:(CGContextRef) context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2 * M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (CGPoint) viewMidPoint {
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width / 2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
    return midPoint;
} 


- (CGFloat) calculateRadius {
    CGFloat size = self.bounds.size.width / 2;
    if(self.bounds.size.height < self.bounds.size.width){
        size = self.bounds.size.height / 2;    
    }    
    size *= self.scale;
    return size;
}

- (void) setLineColorAndStroke:(CGContextRef)context 
{
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
}

#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
- (void) drawEyesBasedOn:(CGPoint) midPoint inRadius: (CGFloat)radius inContext: (CGContextRef) context
{
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - radius * EYE_H;
    eyePoint.y = midPoint.y - radius * EYE_V;
    [self drawCircleAtPoint: eyePoint withRadius: radius * EYE_RADIUS inContext:context];
    eyePoint.x += radius * EYE_H * 2;    
    [self drawCircleAtPoint: eyePoint withRadius: radius * EYE_RADIUS inContext:context];
}

#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
- (void) drawMouthBasedOn:(CGPoint) midPoint inRadius: (CGFloat) radius inContext: (CGContextRef) context
{
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * radius;
    mouthStart.y = midPoint.y + MOUTH_V * radius;
    
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * radius * 2;

    CGPoint mouthControlPoint1 = mouthStart;
    mouthControlPoint1.x += MOUTH_H * radius * 2/3;
    
    CGPoint mouthControlPoint2 = mouthEnd;
    mouthControlPoint1.x -= MOUTH_H * radius * 2/3;

    float smile = [self.dataSource smileForFaceView: self];
    if(smile < -1) smile = -1;
    if(smile > 1)  smile = 1;
    
    CGFloat smileOffSet = MOUTH_SMILE * radius * smile;
    mouthControlPoint1.y += smileOffSet;
    mouthControlPoint2.y += smileOffSet;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthControlPoint1.x, mouthControlPoint1.y, 
                                        mouthControlPoint2.x, mouthControlPoint2.y, 
                                            mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext(); // << only callable in drawRec
    CGPoint midPoint = [self viewMidPoint];
    CGFloat radius = [self calculateRadius];
    [self setLineColorAndStroke: context];
    [self drawCircleAtPoint: midPoint withRadius: radius inContext:context];
    [self drawEyesBasedOn:midPoint inRadius:radius inContext:context];
    [self drawMouthBasedOn:midPoint inRadius:radius inContext:context];
}

@end
