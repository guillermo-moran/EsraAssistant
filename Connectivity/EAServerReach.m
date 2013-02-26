//
//  EAServerReach.m
//  ESRA
//
//  Created by Guillermo Moran on 8/31/12.
//
//

#import "EAServerReach.h"

#import "ViewController.h"

#import "EADataHandler.h"
#import "EAResponseController.h"

@implementation EAServerReach

@synthesize response, returnData;

-(void)submitString:(NSString*)string {
    
    NSString* url;
    
    
    
    //NSString* nickname = [dataHandler nickname];
    //NSString* wolframAlphaKey = [dataHandler wolframKey];
    
    if ([EADataHandler setLanguage] == 0) {
         url = @"http://fr0stdev.cz.cc/ESRA/ESRA_Server-EN.php";
        //url = @"http://www.imokhles.com/Server_Example.php";
    }
    else if ([EADataHandler setLanguage] == 1) {
        url = @"http://fr0stdev.cz.cc/ESRA/ESRA_Server-ES.php";
    }
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSData *requestBody = [[NSString stringWithFormat:@"request=%@&nickname=%@", string, [EADataHandler nickname]] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    
    
    NSURLConnection *serverConnect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [serverConnect start];
    
    
    
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
    
    mainController = [[ViewController alloc] init];
    
    //NSError *error = [request error];
    
    // NSString *response = [request responseString];
    
    NSString* errorPhrase;
    
    if ([EADataHandler setLanguage] == 0) {
        errorPhrase = @"Something has gone awry with the server. Could you try again later?";
    }
    if ([EADataHandler setLanguage]== 1) {
        errorPhrase = @"Lo siento, pero no podía conectarme con el servidor";
    }
    else if ([EADataHandler setLanguage] == 2) {
        errorPhrase = @"Je suis désolé, mais je n'ai pas pu vous connecter au serveur";
    }
    
    [mainController speak:errorPhrase];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingStateChanged"
                                                        object:nil];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSString* responseStr = [response stringByReplacingOccurrencesOfString:@"<_NICKNAME_>" withString:[[NSUserDefaults standardUserDefaults] objectForKey:@"NickName"]];
    
    
    /*
    if ([response isEqualToString:@""]) {
         response = @"I forgot";
    }
    */
    
    mainController = [[ViewController alloc] init];
    
    EAResponseController* meh = [EAResponseController sharedInstance];
    [meh addMessage:[NSString stringWithFormat:@"\"%@\"", responseStr]];
                                 
    [mainController handleServerResult:responseStr];
    
    NSLog(@"Recieved Response: %@",responseStr);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadingStateChanged"
                                                        object:nil];
    
    //[mainController stopMicAnimation];
    
}


@end
