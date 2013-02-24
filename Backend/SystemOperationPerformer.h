//
//  SystemOperationPerformer.h
//  ESRA
//
//  Created by Guillermo Moran on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class ViewController;
@interface SystemOperationPerformer : NSObject <MFMessageComposeViewControllerDelegate> {
    ViewController* mainView;
}


@end
