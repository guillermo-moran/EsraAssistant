//
//  EAGoogleConnect.h
//  ESRA
//
//  Created by Guillermo Moran on 9/14/12.
//
//

#import <Foundation/Foundation.h>

@class ViewController;
@interface EAGoogleConnect : NSObject {
    
    NSMutableData* returnData;
    NSString *result;
    
    ViewController* mainController;
}

-(void)submitSpeech;

@end
