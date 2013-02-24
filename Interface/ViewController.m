//
//  ViewController.m
//  iSpeak
//
//  Created by Guillermo Moran on 11/23/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import "ViewController.h"
#import "ESRASettings.h"

#import <Twitter/Twitter.h>

#import "EAPlugin.h"

#import "EASpeaker.h"
#import "EAMusicPlayer.h"

#import "EAWeatherData.h"
#import "EAClockData.h"
#import "EAImageData.h"

#import "EADataHandler.h"
#import "EAResponseController.h"

#import "EAGoogleConnect.h"
#import "EAServerReach.h"

@implementation ViewController
@synthesize table, cell, listOfMessages, isDataView, isResponse, micIndicator, micPlayer;

 
-(void)startMicAnimation {

    
    NSLog(@"Started Mic Animation");
    
    if (!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) {
            //iPhone 5
            micIndicator = [[EALoadingView alloc] init];
            micIndicator.frame = CGRectMake(133, 483, 55 ,55);
            [micIndicator setTag:1337];
            [self.view addSubview:micIndicator];
            [micIndicator animate];
            
        }
        else {
            //Regular iPhone
            micIndicator = [[EALoadingView alloc] init];
            micIndicator.frame = CGRectMake(133, 395, 55 ,55);
            [micIndicator setTag:1337];
            [self.view addSubview:micIndicator];
            [micIndicator animate];
            
        }
        
        
    }
    else {
        
        micIndicator = [[EALoadingView alloc] init];
        micIndicator.frame = CGRectMake(357, 936, 54 ,54);
        [micIndicator setTag:1337];
        [self.view addSubview:micIndicator];
        [micIndicator animate];
        
        
    }
     
    isLoading = YES;
}
-(void)stopMicAnimation {
    NSLog(@"Stopped Mic Animation");
    isLoading = NO;
    [micIndicator removeFromSuperview];
    //micIndicator = nil;
}




-(IBAction)showSettingsPanel:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        ESRASettings* prefs = [[ESRASettings alloc] initWithNibName:@"ESRASettings-iPad" bundle:nil];
        
        prefs.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self presentModalViewController:prefs animated:YES];
        
    }
    else {
        ESRASettings* prefs = [[ESRASettings alloc] initWithNibName:@"ESRASettings" bundle:nil];
        
        prefs.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:prefs animated:YES];
    }
   
    
}

//============================ SYSTEM OPERATIONS ==========================//

-(void)sendTweet:(NSString*)message {
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter setInitialText:message];
    
    
    //optional
    //[twitter addImage:[UIImage imageNamed:@"emailIcon.png"]];
    //[twitter addURL:[NSURL URLWithString:[NSString stringWithString:@"gjrewoirfhowrihgf0ij"]]];
    
    if([TWTweetComposeViewController canSendTweet]){
        [self presentViewController:twitter animated:YES completion:nil];
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Unable to tweet"
                                                            message:@"You might be in Airplane Mode or not have service. Try again later."
                                                           delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        if (TWTweetComposeViewControllerResultDone) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Tweeted"
                                                                message:@"You successfully tweeted"
                                                               delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        } else if (TWTweetComposeViewControllerResultCancelled) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ooops..."
                                                                message:@"Something went wrong, try again later"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        [self dismissModalViewControllerAnimated:YES];
    };
}


-(void)openApp:(NSString*)appName {
    
}


-(void)getTime {
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"hh:mm"];
    
    NSDate* now = [[NSDate alloc] init];
    
    NSString* timeString = [format stringFromDate:now];
    
    
    NSString* finalTime = [NSString stringWithFormat:@"It is %@", timeString];
    
    responseController = [EAResponseController sharedInstance];
    [responseController addMessage:finalTime];
    
    
    
}
-(void)getDate { //No, this will not get you a date with a girl --
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy"];
    
    NSDate* now = [[NSDate alloc] init];
    
    NSString* dateString = [format stringFromDate:now];
    
  
    NSString* finalDate = [NSString stringWithFormat:@"Today it is %@", dateString];
    responseController = [EAResponseController sharedInstance];
    [responseController addMessage:finalDate];
}

-(IBAction)showTextBox:(id)sender {
    if (inputField.hidden) {
        [inputField setHidden:NO];
    }
    else {
        [inputField setHidden:YES];
    }
        
}


-(IBAction)sendCommand:(id)sender {
    
    [self analyzeText:inputField.text];
    [sender resignFirstResponder];
     
    
}
    
    
-(void)analyzeText:(NSString*)recievedString { 
    isResponse = NO;

    
    if ([recievedString hasPrefix:@"tweet"]) {
        NSString* tweetStr = [recievedString stringByReplacingOccurrencesOfString:@"tweet " withString:@""];
        [self sendTweet:tweetStr];
        
        [self stopMicAnimation];
    }
    else if ([recievedString hasPrefix:@"play song"]) {
        
        [self addMessage:[NSString stringWithFormat:@"%@",recievedString]];
        NSString* songTitle = [recievedString stringByReplacingOccurrencesOfString:@"play song " withString:@""];
        
        EAMusicPlayer* player = [[EAMusicPlayer alloc] init];
        //[songTitle retain];
        [player playSongWithTitle:songTitle];
        
        [self stopMicAnimation];
        
    }
    else if ([recievedString hasPrefix:@"play "]) {
        
        [self addMessage:[NSString stringWithFormat:@"%@",recievedString]];
        NSString* songTitle = [recievedString stringByReplacingOccurrencesOfString:@"play " withString:@""];
        EAMusicPlayer* player = [[EAMusicPlayer alloc] init];
        //[songTitle retain];
        [player playSongWithTitle:songTitle];
        
        [self stopMicAnimation];
    }
    else if ([recievedString hasPrefix:@"pause"]) {
        
        [self addMessage:[NSString stringWithFormat:@"%@",recievedString]];
        
        EAMusicPlayer* player = [[EAMusicPlayer alloc] init];
        //[songTitle retain];
        [player pause];
        
        [self stopMicAnimation];
    }
    else if ([recievedString hasPrefix:@"call me"]) {
     
     nickname = [recievedString stringByReplacingOccurrencesOfString:@"call me" withString:@""];
     
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setObject:nickname forKey:@"NickName"];
     [defaults synchronize];
     
     
     [self addMessage:[NSString stringWithFormat:@"%@",recievedString]];
     
     [self speak:[NSString stringWithFormat:@"Okay, from now on I will call you %@",nickname]];
        
        [self stopMicAnimation];
         
     }
     
    else if ([recievedString hasPrefix:@"google"]) {
        NSString* query = [recievedString stringByReplacingOccurrencesOfString:@"google " withString:@""];
        NSString* formatted = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSString* searchURL = [NSString stringWithFormat:@"http://www.google.com/search?q=%@", formatted];
        NSURL *url = [NSURL URLWithString:searchURL];
        [[UIApplication sharedApplication] openURL:url];
        
        [self stopMicAnimation];
        
    }
    else if ([recievedString hasPrefix:@"send text message to"]) {
        NSString* removedCommand = [recievedString stringByReplacingOccurrencesOfString:@"send text message to " withString:@""];
        
        NSString* removedOne = [removedCommand stringByReplacingOccurrencesOfString:@"one" withString:@"1"];
        NSString* removedTwo = [removedOne stringByReplacingOccurrencesOfString:@"two" withString:@"2"];
        NSString* removedThree = [removedTwo stringByReplacingOccurrencesOfString:@"three" withString:@"3"];
        NSString* removedFour = [removedThree stringByReplacingOccurrencesOfString:@"four" withString:@"4"];
        NSString* removedFive = [removedFour stringByReplacingOccurrencesOfString:@"five" withString:@"5"];
        NSString* removedSix = [removedFive stringByReplacingOccurrencesOfString:@"six" withString:@"6"];
        NSString* removedSeven = [removedSix stringByReplacingOccurrencesOfString:@"seven" withString:@"7"];
        NSString* removedEight = [removedSeven stringByReplacingOccurrencesOfString:@"eight" withString:@"8"];
        NSString* removedNine = [removedEight stringByReplacingOccurrencesOfString:@"nine" withString:@"9"];
        NSString* removedZero = [removedNine stringByReplacingOccurrencesOfString:@"zero" withString:@"0"];
        NSString* number = [removedZero stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [self sendSMS:number];
        
        [self stopMicAnimation];
        
        
    }
    else if ([recievedString hasPrefix:@"call"]) {
        NSString* removedCommand = [recievedString stringByReplacingOccurrencesOfString:@"call " withString:@""];
        
        NSString* removedOne = [removedCommand stringByReplacingOccurrencesOfString:@"one" withString:@"1"];
        NSString* removedTwo = [removedOne stringByReplacingOccurrencesOfString:@"two" withString:@"2"];
        NSString* removedThree = [removedTwo stringByReplacingOccurrencesOfString:@"three" withString:@"3"];
        NSString* removedFour = [removedThree stringByReplacingOccurrencesOfString:@"four" withString:@"4"];
        NSString* removedFive = [removedFour stringByReplacingOccurrencesOfString:@"five" withString:@"5"];
        NSString* removedSix = [removedFive stringByReplacingOccurrencesOfString:@"six" withString:@"6"];
        NSString* removedSeven = [removedSix stringByReplacingOccurrencesOfString:@"seven" withString:@"7"];
        NSString* removedEight = [removedSeven stringByReplacingOccurrencesOfString:@"eight" withString:@"8"];
        NSString* removedNine = [removedEight stringByReplacingOccurrencesOfString:@"nine" withString:@"9"];
        NSString* removedZero = [removedNine stringByReplacingOccurrencesOfString:@"zero" withString:@"0"];
        NSString* number = [removedZero stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [self callNumber:number];
        
        [self stopMicAnimation];
        
        
    }
    
    else if ([recievedString hasPrefix:@"debug"]) {
        
        [self stopMicAnimation];
        
        if ([recievedString hasSuffix:@"on"]) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"debug_is_on"];
            debugModeEnabled = YES;
            [self speak:@"Debug mode is now enabled"];
            
        }
        else if ([recievedString hasSuffix:@"off"]) {
        
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"debug_is_on"];
            debugModeEnabled = NO;
            [self speak:@"Debug mode is now disabled"];
            
        }
        else
            [self speak:@"Debug mode help: Warning, for testing purposes only. Debug mode may be buggy. Some of these new features are untested or buggy and issues may arise. To enable, say \"debug on\". To disable, say \"debug off\"."];
    }
    
    else {
        if (![recievedString isEqualToString:@""]) {
            /*
            [self addMessage:[NSString stringWithFormat:@"%@",recievedString]];
        
            finalString = recievedString;
            [self sendRequest];
             */
            [self checkUserCommandsWithString:recievedString];
        }
    }
    
    
    
}

-(void)checkUserCommandsWithString:(NSString*)recievedString {
    
    [self addMessage:recievedString];
    
    isResponse = NO;
    //NSBundle *main = [NSBundle mainBundle];
    //NSString* path = [main resourcePath];
    
    //NSString* bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",path,recievedString];
    NSString* bundlePath = [NSString stringWithFormat:@"var/mobile/ESRA/Plugins/%@.bundle",recievedString];
    if ([[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
        
        [self stopMicAnimation];
        
        NSBundle *pluginBundle = [NSBundle bundleWithPath:bundlePath];
        [pluginBundle load];
        Class principal = [pluginBundle principalClass];
        EAPlugin* cats = [[principal alloc] init];
        
        if ([cats pluginResponse]) {
        
            [self speak:[cats pluginResponse]];
        
        }
        
        if ([cats isDataView]) {
            [self speak:@"Adding data views is not yet supported on this version of Esra."];
        }
        
        return;
    }
    serverReach = [[EAServerReach alloc] init];
    //serverReach.mainController = self;
    [serverReach submitString:recievedString];
    


}

-(void)addData:(UIView *)view message:(NSString *)message {
    
    [responseController addData:view message:nil];
    
}

-(void)addMessage:(NSString *)message {
    
    
    [responseController addMessage:message];
    
}
                    
 
//============================== SPEECH RECOGNITION ===========================//

-(IBAction)beginListening {
   
    NSLog(@"Listening Toggled");
    
    if (!isLoading) {
        NSError* error;
        if (recorder.recording)
        {
            NSLog(@"Stopped Recording");
            NSString* recorderSound = [[NSBundle mainBundle] pathForResource:@"stop-rec" ofType:@"mp3"];
            NSURL *soundURL = [[NSURL alloc] initFileURLWithPath: recorderSound];
            micPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
            [micPlayer setDelegate:self];
            [micPlayer prepareToPlay];
            [micPlayer play];
            
            [micDetector setProgress:0];
            
            [recorder stop];
            
            if (error) {
                UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [errorAlert show];
                
                
            }
            
        }
        else {
            NSLog(@"Started Recording");
            NSString* recorderSound = [[NSBundle mainBundle] pathForResource:@"start-rec" ofType:@"mp3"];
            NSURL *soundURL = [[NSURL alloc] initFileURLWithPath: recorderSound];
            micPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
            [micPlayer setDelegate:self];
            [micPlayer prepareToPlay];
            [micPlayer play];
            
            [recorder record];
            
            if (error) {
                UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"An Error Occured" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [errorAlert show];
                
                
            }
            /*
             CFBundleRef mainBundle= CFBundleGetMainBundle();
             CFURLRef soundFileURLRef;
             soundFileURLRef = CFBundleCopyResourceURL(mainBundle,(CFStringRef) @"start-rec", CFSTR ("mp3"), NULL);
             UInt32 soundID;
             AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
             AudioServicesPlaySystemSound(soundID);
             
             [recorder record];  
             
             //[self.view makeToast:@"Listening..." duration:2.0 position:@"top"]; Debugging ;P
             
             //recorderSound = [[NSBundle mainBundle] pathForResource:@"start-rec" ofType:@"mp3"];
             return;
             */
            
        }
        
        
        /*
         NSFileManager *fm = [NSFileManager defaultManager];
         
         err = nil;
         [fm removeItemAtPath:[url path] error:&err];
         if(err)
         NSLog(@"File Manager: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
         */

    }
    
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    if (flag) {
        EAGoogleConnect* googleConnect = [[EAGoogleConnect alloc] init];
        [googleConnect submitSpeech];
        [self startMicAnimation];
    }
    else {
        responseController = [EAResponseController sharedInstance];
        [responseController addMessage:@"Sorry, I didn't catch that. Could you try again?"];
        
    }
}


- (void)levelTimerCallback:(NSTimer *)timer {
	
    if(recorder.isRecording)
    {        
        [recorder updateMeters];
        double avgPowerForChannel = pow(10, (0.05 * [recorder averagePowerForChannel:0]));
        double final = avgPowerForChannel + .3;
		[micDetector setProgress:final animated:YES];
    }

    
}



-(void)speak:(NSString *)response {
    
    NSLog(@"Speaking response:%@", response);
    
    isResponse = YES;
    
    response = [NSString stringWithFormat:@"\"%@\"",response];
    
    if ([response hasPrefix:@"\n\n\n\n\n"]) {
        response = [response stringByReplacingOccurrencesOfString:@"\n\n\n\n\n\n" withString:@""];
        
        if ([response isEqualToString:@"\"\""]) {
            response = @"\"I forgot\"";
            //response = @"I forgot";
        }
    }
    
    
    [EASpeaker speak:response];
    
    
    //[self addMessage:response];
}
  
// ================================== COMMAND FINDER ===========================//

- (void)handleServerResult:(NSString*)response {
    
    NSLog(@"Handling response from Server: %@", response);
    
    if ([response hasPrefix:@"<Get_Weather>"]) {
        

        
        EAWeatherData* weatherData = [[EAWeatherData alloc] initWithNibName:@"EAWeatherData" bundle:nil];
        
        [weatherData beginParsing];
        
        responseController = [EAResponseController sharedInstance];
        [responseController addMessage:[[NSString stringWithFormat:@"It is currently %@ degrees, %@, in %@",weatherData.currentTemp, weatherData.currentConditions, weatherData.city] copy]];
        
       

        [self addData:weatherData.view message:nil];
        
    }
    else if ([response hasPrefix:@"<!DOCTYPE HTML>"]) {
        response = @"The server is unreachable at this time, please try again later";
    }
    else if ([response hasPrefix:@"<Get_Date>"]) {
        [self getDate];
        
    }
    else if ([response hasPrefix:@"<Get_Time>"]) {
        
        
        
        [self getTime];
    
        EAClockData* clockData;
        
        
        clockData = [[EAClockData alloc] initWithNibName:@"EAClockData" bundle:nil];
        
        [self addData:clockData.view message:@"Clock time here"];
                
        
    }
    else if ([response hasPrefix:@"<Show_Image>"]) {
        
        
        
        NSString* imageURLString = [response stringByReplacingOccurrencesOfString:@"<Show_Image>: " withString:@""];
        
        NSLog(@"Showing Image: %@", imageURLString);
        
        EAImageData* imageData = [[EAImageData alloc] initWithNibName:@"EAImageData" bundle:nil];
        
        [self addData:imageData.view message:nil];
        
        [imageData assignImage:[NSString stringWithFormat:@"%@",imageURLString]];
       
    }
    else if ([response hasPrefix:@"OPEN_APP_WITH_URL: = "]) {
        NSString* URLMethod = 
        [response stringByReplacingOccurrencesOfString:@"OPEN_APP_WITH_URL: = " withString:@""];
    
        NSURL *url = [NSURL URLWithString:URLMethod];
        [[UIApplication sharedApplication] openURL:url];
    }
    else if ([response hasPrefix:@"RUN_COMMAND: "]) {
        NSString* command = [response stringByReplacingOccurrencesOfString:@"RUN_COMMAND: " withString:@""];
        system([command UTF8String]);
    
    }
    else if ([response hasPrefix:@"<Restart_SB>"]) {
        system("killall -9 SpringBoard");
        }
    else if ([response hasPrefix:@"<Reboot>"]) {
        system("freeboot");
        
        }
    else if ([response hasPrefix:@"<Shut_Down>"]) {
        system("malt");
    }
    
    else {
        
        [self speak:response];
    }
    NSLog(@"Recieved Response from Server: %@",response);
    [self stopMicAnimation];
    
    
}




// ================================= SMS CONTROLLER ===============================//

-(void)sendSMS:(NSString*)number {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"";
		controller.recipients = [NSArray arrayWithObjects:number, nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}
}

-(void)callNumber:(NSString*)number {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
            [controller dismissModalViewControllerAnimated:YES];
			break;
		case MessageComposeResultFailed:
			NSLog(@"An error occured");
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//========================================Table View Controllers ================================//


-(void)loadAudioSession {
    
    NSLog(@"Loading Audio Session");
    
    NSError *error;
    
    //Load Audio Session
    audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
    [audioSession setActive:YES error:&error];
    
    //Load Recorder
    NSURL *soundFileURL = [NSURL fileURLWithPath:@"/var/mobile/ESRA/ESRA-Temp.wav"];
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey]; 
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    
    recorder = [[AVAudioRecorder alloc]
                initWithURL:soundFileURL
                settings:recordSetting
                error:&error];
    
    recorder.meteringEnabled = YES;
    
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    
    levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    
    
    UInt32 ASRoute = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (
                             kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (ASRoute),
                             &ASRoute
                             );
     
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        UIAlertView* recorderError = [[UIAlertView alloc] initWithTitle:@"An Error Occurred" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [recorderError show];
        
    }     
    
}




#pragma mark - View lifecycle

-(void)reloadTable:(NSNotification *)notification {
    
   
    
    //[self.table reloadData];
    
    //Scroll to bottom of Table View
    
    //[self.table reloadData];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[responseController.messagesArray count]-1 inSection:0];
    [self.table insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([responseController.messagesArray count] - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewDidLoad
{
    
    
    
    isLoading = NO;
    
	// Do any additional setup after loading the view, typically from a nib.
    
    nickname = [EADataHandler nickname];
    
    responseController = [EAResponseController sharedInstance];
    self.table.delegate = responseController;
    self.table.dataSource = responseController;
    
    
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    //self.view.backgroundColor = background;
    
    //[background release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:@"TableDataChanged"
                                               object:nil];
    
    NSString* welcomeStr;
    
    
    debugModeEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"debug_is_on"];
    
    
    if ([EADataHandler setLanguage] == 0) {
        welcomeStr = @"\"How may I help you?\"";
    }
    else if ([EADataHandler setLanguage] == 1) {
        welcomeStr = @"\"Como le puedo ayudar?\"";
    }
    else if ([EADataHandler setLanguage] == 2) {
        welcomeStr = @"\"Comment puis-je vous aider?\"";
    }
    isResponse = YES;
    [self addMessage:welcomeStr];
    
    
    
    [self loadAudioSession];
    
    if ([EADataHandler listenOnLaunch]) {
        [self beginListening];
    }
    
    //[EADataHandler release];
    
    micDetector = [[MicProgressView alloc] init];
    
    
    if (!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    
        
        if ([UIScreen mainScreen].bounds.size.height == 568) {
            //iPhone 5
             micDetector.frame = CGRectMake(149, 497, 25 ,12);
        } 
        else {
            //Regular iPhone
            micDetector.frame = CGRectMake(149, 410, 25 , 12);
        }
        

    }
    else {
        
        micDetector.frame = CGRectMake(372, 949, 25 ,12);
        
        
        EAWeatherData* weatherDataView = [[EAWeatherData alloc] initWithNibName:@"EAWeatherData" bundle:nil];
        
        EAClockData* clockData = [[EAClockData alloc] initWithNibName:@"EAClockData" bundle:nil];
        
        [weatherView addSubview:weatherDataView.view];
        [timeView addSubview:clockData.view];
    }
    
    self.micIndicator = [[EALoadingView alloc] init];
    
    self.micIndicator.frame = CGRectMake(133, 395, 55 ,55);
    [self.view addSubview:micIndicator];
    [self.micIndicator animate];
    [self.micIndicator setHidden:YES];
    
    micDetector.transform=CGAffineTransformMakeRotation(M_PI/-2);
    [self.view addSubview:micDetector];
    [self.view sendSubviewToBack:micDetector];
    [self.view sendSubviewToBack:micButton];
    [self.view sendSubviewToBack:table];
    [self.view sendSubviewToBack:BGImage];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    inputField = nil;
    table = nil;
    recorder = nil;
    micDetector = nil;
    conditions = nil;
    degrees = nil;
    locationName = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    /*
    if (languageSeg == 0) {
      
    }
    else if (languageSeg == 1) {
       
    }
    else if (languageSeg == 2) {
       
    }
    
     */
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{

	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
  
}

@end
