//
//  EAClockData.m
//  ESRA
//
//  Created by Guillermo Moran on 5/18/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "EAClockData.h"

@implementation EAClockData

-(void)updateTime { //Let's do a clock widget!//
    NSDateFormatter *MinuteFormatter = [[NSDateFormatter alloc] init];
    [MinuteFormatter setDateFormat:@"mm"];
    [MinuteFormatter setLocale:[NSLocale currentLocale]];
    
    minutes.text = [MinuteFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"hh"];
    [hourFormatter setLocale:[NSLocale currentLocale]];
    
    time.text = [hourFormatter stringFromDate:[NSDate date]];
	
    
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
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
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
