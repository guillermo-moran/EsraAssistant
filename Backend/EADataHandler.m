//
//  EADataHandler.m
//  ESRA
//
//  Created by Guillermo Moran on 9/27/12.
//
//

#import "EADataHandler.h"

@implementation EADataHandler

#pragma mark Stored Info -

+(NSString*)nickname {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NickName"];
}

+(NSString*)wolframKey {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"WAKey"];
}


#pragma mark Stored Settings -

+(int)setLanguage {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"setLanguage"] intValue];
}

+(int)weatherFormat {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"setWeatherFormat"] intValue];
}

+(int)listenOnLaunch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"listenOnLaunch"];
}

+(int)debugEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"debugEnabled"];
}



@end
