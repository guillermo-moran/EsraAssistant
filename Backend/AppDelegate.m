//
//  AppDelegate.m
//  iSpeak
//
//  Created by Guillermo Moran on 11/23/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import "AppDelegate.h"


#import "ESRASettings.h"
#import "ViewController.h"

//#define kSDK_KEY @"b31f6657a633f6ff29965b002a6fe515"

@implementation AppDelegate

@synthesize window = _window;
@synthesize assistantViewController = _assistantViewController;
@synthesize setupScreen = _setupScreen;


/*
+ (AppDelegate *)appDelegate {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
*/


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //_iSpeech = [ISpeechSDK ISpeech:kSDK_KEY provider:@"com.gmoran.esra" application:@"ESRA" useProduction:YES];
    
    //[self connectToServer];
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    
    //-------------------------- UDUD CHECKERS ----------------------------//

    
    if (![[NSUserDefaults standardUserDefaults]
          boolForKey:@"SetupIsDone"]) {
		
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch.
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.setupScreen = [[ESRASettings alloc] initWithNibName:@"WelcomeScreen-iPad" bundle:nil];
        }
        else {
        
            self.setupScreen = [[ESRASettings alloc] initWithNibName:@"ESRASettings" bundle:nil];
        }
        
        self.window.rootViewController = self.setupScreen;
        
       [self.window makeKeyAndVisible];
        
	}
    
    else {
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch.
        
    
   
        //self.window.rootViewController = self.viewController;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            self.assistantViewController = [[ViewController alloc] initWithNibName:@"AssistantView-iPad" bundle:nil];
            
            self.window.rootViewController = self.assistantViewController;
            
        }
        else {
            
            if([UIScreen mainScreen].bounds.size.height == 568){
                self.assistantViewController = [[ViewController alloc] initWithNibName:@"ViewController-i5" bundle:nil];
                
            } else{
                self.assistantViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
                         
            }
            
            
        
            self.window.rootViewController = self.assistantViewController;
        }
        
        [self.window makeKeyAndVisible];
        
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:@"/var/mobile/ESRA/ESRA-Temp.flac"]) {
    
        [fm removeItemAtPath:@"/var/mobile/ESRA/ESRA-Temp.flac" error:nil];
    }
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
