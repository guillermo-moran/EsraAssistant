//
//  EADataHandler.h
//  ESRA
//
//  Created by Guillermo Moran on 9/27/12.
//
//

#import <Foundation/Foundation.h>

@interface EADataHandler : NSObject {
    
}

+(NSString*)nickname;
+(NSString*)wolframKey;

+(int)setLanguage;
+(int)weatherFormat;
+(int)listenOnLaunch;
+(int)debugEnabled;


@end
