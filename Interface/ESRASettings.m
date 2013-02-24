//
//  ESRASettings.m
//  ESRA
//
//  Created by Guillermo Moran on 12/11/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import "ESRASettings.h"
#import "ViewController.h"

@implementation ESRASettings

-(IBAction)languageChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInt:[languageControl selectedSegmentIndex]] forKey:@"setLanguage"];
	[defaults synchronize];
    
    
}
-(IBAction)weatherChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSNumber numberWithInt:[weatherSegment selectedSegmentIndex]] forKey:@"setWeatherFormat"];
	[defaults synchronize];
    
    
}

-(IBAction)finishedEditing:(id)sender {
    [sender resignFirstResponder];
}

-(IBAction)saveData:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:nickname.text forKey:@"NickName"];
    [defaults setObject:zipcode.text forKey:@"ZipCode"];
    [wolframKeyField.text uppercaseString];
    [defaults setObject:wolframKeyField.text forKey:@"WAKey"];
    
    if (LOLSwitch.isOn) {
        [defaults setBool:YES forKey:@"listenOnLaunch"];
    }
    else {
        [defaults setBool:NO forKey:@"listenOnLaunch"];
    }
    [defaults synchronize];
    //HomeView* home = [[[HomeView alloc] initWithNibName:@"HomeView" bundle:nil] autorelease];
    //home.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self presentModalViewController:home animated:YES];
    
    if (![[NSUserDefaults standardUserDefaults]
          boolForKey:@"SetupIsDone"]) {
        ViewController* home = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        home.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:home animated:YES];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:@"SetupIsDone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    nickname.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"NickName"];
    zipcode.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"ZipCode"];
    wolframKeyField.text= [[NSUserDefaults standardUserDefaults] objectForKey:@"WAKey"];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    weatherSegment.selectedSegmentIndex = [[defaults objectForKey:@"setWeatherFormat"] intValue];
    languageControl.selectedSegmentIndex = [[defaults objectForKey:@"setLanguage"] intValue];
    LOLSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"listenOnLaunch"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
