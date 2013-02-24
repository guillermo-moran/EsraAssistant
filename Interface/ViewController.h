//
//  ViewController.h
//  iSpeak
//
//  Created by Guillermo Moran on 11/23/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

//#import "TableCells.h"

#import "MicProgressView.h"
#import "EALoadingView.h"


@class TableCells, EAServerReach, EAResponseController;
@interface ViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, MFMessageComposeViewControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, NSURLConnectionDelegate, UIPopoverControllerDelegate> {
   
    
    //GUI Stuff
    IBOutlet UITextField* inputField;
    IBOutlet UIImageView* BGImage;
    IBOutlet UIButton* micButton;
    
    UIView* dataView;
    
    //Other Data
    
    BOOL debugModeEnabled;
    BOOL isLoading;
    
    
    NSString* nickname;
    
    //Microphone
    MicProgressView* micDetector;
    
    
    //Table View
    IBOutlet UITableView *table;
    IBOutlet UITableViewCell* Cells;
    EAResponseController* responseController;
    
    NSString* stringToAdd;
    
    //Weather
    IBOutlet UILabel* conditions;
    IBOutlet UILabel* degrees;
    IBOutlet UILabel* locationName;
    
    
    //Speech Recognition
    AVAudioRecorder *recorder;
    NSTimer* levelTimer;
    //SystemSoundID* systemSoundID;
    AVAudioSession* audioSession;
    
    
    //Server Connectivity
    EAServerReach* serverReach;
    
    
    //iPad Interface
    IBOutlet UIView* weatherView;
    IBOutlet UIView* timeView;
 
    //IBOutlet UILabel* resultLabel; //DEBUG
    
    

}

//Microphone
-(void)startMicAnimation;
-(void)stopMicAnimation;

//Voice Recognition
-(IBAction)beginListening;
-(void)speak:(NSString*)response;
-(void)levelTimerCallback:(NSTimer *)timer;
-(void)loadAudioSession;

//Application Control
-(IBAction)showTextBox:(id)sender;
-(void)addMessage:(NSString*)message;
-(void)addData:(UIView*)view message:(NSString*)message;
-(IBAction)showSettingsPanel:(id)sender;

//Server Command Submission/Recognition
-(void)analyzeText:(NSString*)recievedString;
-(IBAction)sendCommand:(id)sender;
-(void)checkUserCommandsWithString:(NSString*)recievedString;

//System Actions
-(void)sendSMS:(NSString*)number;
-(void)callNumber:(NSString*)number;
-(void)sendTweet:(NSString*)message;

//System Operations
-(void)getTime;
-(void)getDate;


//NEW METHODS

//table
-(void)reloadTable:(NSNotification *)notification;

//server parser
-(void)handleServerResult:(NSString*)response;

@property (nonatomic) BOOL isDataView;
@property (nonatomic) BOOL isResponse;

@property (nonatomic,retain) EALoadingView* micIndicator;
@property (nonatomic,strong) TableCells* cell;
@property (nonatomic,strong) IBOutlet UITableView* table;
@property (nonatomic,weak) NSMutableArray* listOfMessages;

//@property (nonatomic,assign) EAServerReach* serverReach;

@end