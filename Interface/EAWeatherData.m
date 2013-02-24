//
//  EAWeatherData.m
//  ESRA
//
//  Created by Guillermo Moran on 5/14/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "EAWeatherData.h"
#import "EADataHandler.h"

#import "EAResponseController.h"

@implementation EAWeatherData
@synthesize currentTemp, currentConditions, city;

- (void)beginParsing {
    
    
    
	@autoreleasepool {
    
		NSString* address = @"http://weather.yahooapis.com/forecastrss?p=";
    
    NSString* loc = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZipCode"];
    
    NSString* request;
		
    if ([EADataHandler weatherFormat] == 0) {
        
        request = [NSString stringWithFormat:@"%@%@&u=f",address,loc];
    }
    else if ([EADataHandler weatherFormat] == 1) {
        request = [NSString stringWithFormat:@"%@%@&u=c",address,loc];
    }
    
		NSData* XMLdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:request]];
		NSXMLParser* parser = [[NSXMLParser alloc] initWithData: XMLdata];
		
		[parser setDelegate:self];
		[parser parse];
	}
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
	//NSLog(@"Found Element:%@",elementName);
    
    NSString* conditionCode;
    
    if ([elementName isEqualToString:@"yweather:condition"]) {
		
		currentConditions = [attributeDict valueForKey:@"text"];
		
		conditions.text = currentConditions;
        NSLog(@"Current Conditions: %@", currentConditions);
	}
	if ([elementName isEqualToString:@"yweather:location"]) {
		
        city = [attributeDict valueForKey:@"city"];
        
		locationName.text = city;
        NSLog(@"Current Location: %@", city);
	}
	if ([elementName isEqualToString:@"yweather:forecast"]) {
		
		NSString* lows = [attributeDict valueForKey:@"low"];
		NSString* highs = [attributeDict valueForKey:@"high"];
		
		lowLabel.text = [NSString stringWithFormat:@"L:%@°",lows];
		highLabel.text = [NSString stringWithFormat:@"H:%@°",highs];
	}
	
	if ([elementName isEqualToString:@"yweather:condition"]) {
        
		currentTemp = [attributeDict valueForKey:@"temp"];   
		conditionCode = [attributeDict valueForKey:@"code"];
		
		degrees.text = [NSString stringWithFormat:@"%@°",currentTemp];
        NSLog(@"Current Temp: %@", currentTemp);
		
		//-------------- Determine What Image To Use --------------//
		
		if ([conditionCode isEqualToString:@"0"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"1"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"2"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"3"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"4"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"5"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"6"]) {
			current.image = [UIImage imageNamed:@"sleet.png"];
		}
		else if ([conditionCode isEqualToString:@"7"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"8"]) {
			current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"9"]) {
			current.image = [UIImage imageNamed:@"showers.png"];
		}
		else if ([conditionCode isEqualToString:@"10"]) {
			current.image = [UIImage imageNamed:@"showers.png"];
		}
		else if ([conditionCode isEqualToString:@"11"]) {
			current.image = [UIImage imageNamed:@"showers.png"];
		}
		else if ([conditionCode isEqualToString:@"12"]) {
			current.image = [UIImage imageNamed:@"showers.png"];
		}
		else if ([conditionCode isEqualToString:@"13"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"14"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"15"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"16"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"17"]) {
			current.image = [UIImage imageNamed:@"hail.png"];
		}
		else if ([conditionCode isEqualToString:@"18"]) {
			current.image = [UIImage imageNamed:@"sleet.png"];
		}
		else if ([conditionCode isEqualToString:@"19"]) {
			current.image = [UIImage imageNamed:@"fog.png"];
		}
		else if ([conditionCode isEqualToString:@"20"]) {
			current.image = [UIImage imageNamed:@"fog.png"];
		}
		else if ([conditionCode isEqualToString:@"21"]) {
			current.image = [UIImage imageNamed:@"fog.png"];
		}
		else if ([conditionCode isEqualToString:@"22"]) {
			current.image = [UIImage imageNamed:@"fog.png"];
		}
		else if ([conditionCode isEqualToString:@"23"]) {
			current.image = [UIImage imageNamed:@"dunno.png"];
		}
		else if ([conditionCode isEqualToString:@"24"]) {
			current.image = [UIImage imageNamed:@"sunny.png"];
		}
		else if ([conditionCode isEqualToString:@"25"]) {
			current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"26"]) {
            current.image = [UIImage imageNamed:@"cloudy1.png"];
		}
		else if ([conditionCode isEqualToString:@"27"]) {
            current.image = [UIImage imageNamed:@"cloudy1_night.png"];
		}
		else if ([conditionCode isEqualToString:@"28"]) {
            current.image = [UIImage imageNamed:@"cloudy1.png"];
		}
		else if ([conditionCode isEqualToString:@"29"]) {
            current.image = [UIImage imageNamed:@"cloudy1_night.png"];
		}
		else if ([conditionCode isEqualToString:@"30"]) {
            current.image = [UIImage imageNamed:@"cloudy1.png"];
		}
		else if ([conditionCode isEqualToString:@"31"]) {
            current.image = [UIImage imageNamed:@"sunny_night.png"];
		}
		else if ([conditionCode isEqualToString:@"32"]) {
            current.image = [UIImage imageNamed:@"sunny.png"];
		}
		else if ([conditionCode isEqualToString:@"33"]) {
            current.image = [UIImage imageNamed:@"sunny_night.png"];
		}
		else if ([conditionCode isEqualToString:@"34"]) {
			current.image = [UIImage imageNamed:@"sunny.png"];
		}
		else if ([conditionCode isEqualToString:@"35"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"36"]) {
            current.image = [UIImage imageNamed:@"sunny.png"];
		}
		else if ([conditionCode isEqualToString:@"37"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"38"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"39"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"40"]) {
            current.image = [UIImage imageNamed:@"showers.png"];
		}
		else if ([conditionCode isEqualToString:@"41"]) {
            current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"42"]) {
            current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"43"]) {
            current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"44"]) {
            current.image = [UIImage imageNamed:@"cloudy1.png"];
		}
		else if ([conditionCode isEqualToString:@"45"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"46"]) {
            current.image = [UIImage imageNamed:@"snow1.png"];
		}
		else if ([conditionCode isEqualToString:@"47"]) {
            current.image = [UIImage imageNamed:@"tstorm3.png"];
		}
		else if ([conditionCode isEqualToString:@"3200"]) {
            current.image = [UIImage imageNamed:@"dunno.png"];
		}
		
	}
	
    //EAResponseController* responseController = [EAResponseController sharedInstance];
    //[responseController addMessage:[NSString stringWithFormat:@"It is currently %@ degrees, %@, in %@",self.currentTemp, self.currentConditions, self.city]];
}

-(void)speakWeather {
    
    [self beginParsing];
    
    EAResponseController* responseController = [EAResponseController sharedInstance];
    [responseController addMessage:[NSString stringWithFormat:@"It is currently %@ degrees, %@, in %@",self.currentTemp, self.currentConditions, self.city]];
    
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
    [self beginParsing];
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
