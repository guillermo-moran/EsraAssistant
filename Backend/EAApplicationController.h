//
//  EAApplicationController.h
//  ESRA
//
//  Created by Guillermo Moran on 3/2/13.
//
//

#import <Foundation/Foundation.h>

@interface EAApplicationController : NSObject {
    
}

-(NSDictionary*)applications;

-(void)openApplicationWithName:(NSString*)name;

@end

@interface UIApplication (Undocumented)
- (void)launchApplicationWithIdentifier:(NSString*)identifier suspended:(BOOL)suspended;
@end
