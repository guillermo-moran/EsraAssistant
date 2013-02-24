//
//  ESRASettings.h
//  ESRA
//
//  Created by Guillermo Moran on 12/11/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESRASettings : UIViewController {
    
    IBOutlet UITextField* zipcode;
    IBOutlet UITextField* nickname;
    IBOutlet UITextField* wolframKeyField;
    IBOutlet UISegmentedControl* weatherSegment;
    IBOutlet UISegmentedControl* languageControl;
    IBOutlet UISwitch* LOLSwitch;

}

-(IBAction)finishedEditing:(id)sender;
-(IBAction)saveData:(id)sender;
-(IBAction)languageChanged:(id)sender;
-(IBAction)weatherChanged:(id)sender;

@end
