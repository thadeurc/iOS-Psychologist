//
//  HappinessViewController.m
//  Happiness
//
//  Created by Thadeu Carmo on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;
@end

@implementation HappinessViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget: self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

- (void) handleHappinessGesture: (UIPanGestureRecognizer *) gesture
{
    if(gesture.state == UIGestureRecognizerStateChanged ||
       gesture.state == UIGestureRecognizerStateEnded){
        // translationInView or in view is is used to get/apply the translation in the faceView coordinate system
        CGPoint translation = [gesture translationInView: self.faceView];
        // make it less sentitive
        self.happiness -= translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (float) smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}
@end
