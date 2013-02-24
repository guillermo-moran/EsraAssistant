//
//  EAWeatherData.h
//  ESRA
//
//  Created by Guillermo Moran on 5/14/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAWeatherData : UIViewController <NSXMLParserDelegate> {
    IBOutlet UILabel* degrees;
    IBOutlet UIImageView* current;
    IBOutlet UILabel* conditions;
    IBOutlet UILabel* locationName;
    IBOutlet UILabel* lowLabel;
    IBOutlet UILabel* highLabel;
    IBOutlet UILabel* weatherFormatLabel;
    
    int weatherSeg;
}

-(void)beginParsing;
-(void)speakWeather;

/*
@property (nonatomic, copy) IBOutlet UILabel* degrees;
@property (nonatomic, copy) IBOutlet UILabel* conditions;
@property (nonatomic, copy) IBOutlet UILabel* locationName;
@property (nonatomic, copy) IBOutlet UILabel* lowLabel;
@property (nonatomic, copy) IBOutlet UILabel* highLabel;
@property (nonatomic, copy) IBOutlet UILabel* weatherFormatLabel;
*/
 
@property (nonatomic, strong) NSString* currentTemp;
@property (nonatomic, strong) NSString* currentConditions;
@property (nonatomic, strong) NSString* city;

@end
