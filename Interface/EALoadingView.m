//
//  EALoadingView.m
//  ESRA
//
//  Created by Guillermo Moran on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EALoadingView.h"

@implementation EALoadingView

-(void)animate {
    
    self.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"spinner.png"],
                                         [UIImage imageNamed:@"spinner1.png"],
                                         [UIImage imageNamed:@"spinner2.png"],
                                         [UIImage imageNamed:@"spinner3.png"],
                                         [UIImage imageNamed:@"spinner4.png"],
                                         [UIImage imageNamed:@"spinner5.png"],
                                         [UIImage imageNamed:@"spinner6.png"],
                                         [UIImage imageNamed:@"spinner7.png"],
                                         [UIImage imageNamed:@"spinner7.png"],[UIImage imageNamed:@"spinner8.png"],
                                         nil];
    
    
    //Set the duration of the animation (play with it
    //until it looks nice for you)
    self.animationDuration = 0.5;

    //Start the animation
    [self startAnimating];
}




@end
