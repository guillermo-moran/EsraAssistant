//
//  EAServerReach.h
//  ESRA
//
//  Created by Guillermo Moran on 8/31/12.
//
//

#import <Foundation/Foundation.h>

@class ViewController;
@interface EAServerReach : NSObject {
    
    
    //Server Stuff
    NSMutableData* returnData;
    NSString* response;
    ViewController* mainController;
}

-(void)submitString:(NSString*)string;

@property (nonatomic, strong) NSMutableData* returnData;
@property (nonatomic, strong) NSString* response;

//@property (nonatomic, assign)ViewController* mainController;

@end
