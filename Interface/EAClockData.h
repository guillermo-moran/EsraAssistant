//
//  EAClockData.h
//  ESRA
//
//  Created by Guillermo Moran on 5/18/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAClockData : UIViewController {
    IBOutlet UILabel* minutes;
    IBOutlet UILabel* time;
}

-(void)updateTime;

@end
