//
//  EAGoogleConnect.m
//  ESRA
//
//  Created by Guillermo Moran on 9/14/12.
//
//

#import "EAGoogleConnect.h"

#import "EADataHandler.h"
#import "EAResponseController.h"

#import "ViewController.h"

@implementation EAGoogleConnect


-(void)submitSpeech {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingStateChanged"
                                                        object:nil];
    
    mainController = [[ViewController alloc] init];
    
    //[mainController startMicAnimation];
    
    
    system("flac /var/mobile/ESRA/ESRA-Temp.wav --sample-rate=16000 -o /var/mobile/ESRA/ESRA-Temp.flac");
    
    NSString *recDir = @"/var/mobile/ESRA/";
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/ESRA-Temp.flac", recDir]];
    
    NSData *flacFile = [NSData dataWithContentsOfURL:url];
    //NSString *audio = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/recordTest.flac", recDir]];
    
    NSString* countryID;
    
    if ([EADataHandler setLanguage] == 0) {
        countryID = @"en-US";
    }
    else if ([EADataHandler setLanguage] == 1) {
        countryID = @"es-MX";
    }
    
    
   //NSString* googleSpeechURL = [NSString stringWithFormat:@"https://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=%@",countryID];
    
    //disable censor
    NSString *googleSpeechURL = [NSString stringWithFormat:@"http://www.google.com/speech-api/v1/recognize?xjerr=1&pfilter=0&client=chromium&lang=%@",countryID];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:googleSpeechURL]];
    
    [request setHTTPMethod:@"POST"];
    
    //set headers
    
    [request addValue:@"Content-Type" forHTTPHeaderField:@"audio/x-flac; rate=16000"];
    
    [request addValue:@"audio/x-flac; rate=16000" forHTTPHeaderField:@"Content-Type"];
    
    //NSString *requestBody = [[NSString alloc] initWithFormat:@"Content=%@", flacFile];
    
    //[request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:flacFile];
    
    [request setValue:[NSString stringWithFormat:@"%d",[flacFile length]] forHTTPHeaderField:@"Content-length"];
    
    
    NSURLConnection *gConnect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [gConnect start];
    //[gConnect release];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    returnData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [returnData appendData:data];
}
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error {
    [mainController speak:@"I was unable to connect to the server at this time. Try again?"];
    
    EAResponseController* responseController = [EAResponseController sharedInstance];
    [responseController addMessage:@"I was unable to connect to the server at this time. Try again?"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingStateChanged"
                                                        object:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    result = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    @try {
        NSRange range = [result rangeOfString:@"{\"utterance\":\""];
        NSString* gspeechhalf = [result substringFromIndex:range.location+14];
        NSRange range2 = [gspeechhalf rangeOfString:@"\",\"confidence"];
        NSString* gspeech = [gspeechhalf substringToIndex:range2.location];
        
        [mainController analyzeText:gspeech];
        EAResponseController* responseController = [EAResponseController sharedInstance];
        [responseController addMessage:gspeech];
    }
    @catch (NSException *exception) {
        
        [mainController speak:@"Sorry, I didn't catch that. Could you try again?"];
        
        EAResponseController* responseController = [EAResponseController sharedInstance];
        
        [responseController addMessage:@"Sorry, I didn't catch that. Could you try again?"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingStateChanged"
                                                            object:nil];
    }
    
    
    
    //[loadingIndicator stopAnimating];
    
    //[self addMessage:result]; DEBUG
    
    NSError* err = nil;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    
    [fm removeItemAtPath:@"/var/mobile/ESRA/ESRA-Temp.flac" error:nil];
    
    if(err) {
        NSLog(@"File Manager: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        
        UIAlertView* errorAlert = [[UIAlertView alloc]initWithTitle:@"An Error Occurred" message:[NSString stringWithFormat:@"File Manager: %@ %d %@", [err domain], [err code], [[err userInfo] description]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [errorAlert show];
    }
    else {
        NSLog(@"Deleted temp flac file successfully!");
    }
    
}


@end
