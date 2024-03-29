//
//  FaceView.h
//  Happiness
//
//  Created by Thadeu Carmo on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource
- (float) smileForFaceView: (FaceView *) sender;
@end

@interface FaceView : UIView
@property (nonatomic) CGFloat scale;
@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;
- (void) pinch: (UIGestureRecognizer *) gesture;
@end
