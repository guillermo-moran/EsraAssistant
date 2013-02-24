//
//  MicProgressView.m
//  ESRA
//
//  Created by Guillermo Moran on 2/12/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "MicProgressView.h"

#define kMicProgressViewFillOffsetX 1
#define kMicProgressViewFillOffsetTopY 1
#define kMicProgressViewFillOffsetBottomY 2

@implementation MicProgressView

- (void)drawRect:(CGRect)rect {
    
    CGSize backgroundStretchPoints = {9, 4}, fillStretchPoints = {8, 3};
    
    // Initialize the stretchable images.
    UIImage *background = [[UIImage imageNamed:@"MicProgress-BG.png"] stretchableImageWithLeftCapWidth:backgroundStretchPoints.width topCapHeight:backgroundStretchPoints.height];
    
    UIImage *fill = [[UIImage imageNamed:@"MicProgress-Fill.png"] stretchableImageWithLeftCapWidth:fillStretchPoints.width topCapHeight:fillStretchPoints.height];  
    
    // Draw the background in the current rect
    [background drawInRect:rect];
    
    // Compute the max width in pixels for the fill.  Max width being how
    // wide the fill should be at 100% progress.
    NSInteger maxWidth = rect.size.width - (2 * kMicProgressViewFillOffsetX);
    
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding 
    // to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    
    // Create the rectangle for our fill image accounting for the position offsets,
    // 1 in the X direction and 1, 3 on the top and bottom for the Y.
    CGRect fillRect = CGRectMake(rect.origin.x + kMicProgressViewFillOffsetX,
                                 rect.origin.y + kMicProgressViewFillOffsetTopY,
                                 curWidth,
                                 rect.size.height - kMicProgressViewFillOffsetBottomY);
    
    // Draw the fill
    [fill drawInRect:fillRect];
}

@end