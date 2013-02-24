//
//  AppDelegate.h
//  iSpeak
//
//  Created by Guillermo Moran on 11/23/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ESRASettings;
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController* assistantViewController;

@property (strong, nonatomic) ESRASettings* setupScreen;

//@property (nonatomic, retain, readonly) ISpeechSDK *iSpeech;
//+ (AppDelegate *)appDelegate;


@end
