//
//  EASpeaker.m
//  ESRA
//
//  Created by Guillermo Moran on 3/24/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "EASpeaker.h"
#import "VSSpeechSynthesizer.h"

@implementation EASpeaker

+(void)speak:(NSString *)messageToSpeak {
    
    VSSpeechSynthesizer* speaker;
    
    
    speaker = [[NSClassFromString(@"VSSpeechSynthesizer") alloc] init];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int setLanguage = [[defaults objectForKey:@"setLanguage"] intValue];
    
    
    NSString* languageID;
    
    if (setLanguage == 0) {
        languageID = @"en-US";
    }
    else if (setLanguage == 1) {
        languageID = @"es-MX";
    }
    
    NSLog(@"Speaking string: %@", messageToSpeak);
    [speaker startSpeakingString:messageToSpeak toURL:nil withLanguageCode:languageID];
  
    
}

@end
