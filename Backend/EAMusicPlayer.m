//
//  EAMusicPlayer.m
//  ESRA
//
//  Created by Guillermo Moran on 5/23/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "EAMusicPlayer.h"
#import "ViewController.h"
#import "EAResponseController.h"

@implementation EAMusicPlayer

-(void)playSongWithTitle:(NSString *)title {
    
    //Create an instance of MPMusicPlayerController
    MPMusicPlayerController* myPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    //Create a query that will return all songs by The Beatles grouped by album
    MPMediaQuery* query = [MPMediaQuery songsQuery];
    
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:title forProperty:MPMediaItemPropertyTitle comparisonType:MPMediaPredicateComparisonContains]];
    
    [query setGroupingType:MPMediaGroupingTitle];
    
    //Pass the query to the player
    [myPlayer setQueueWithQuery:query];
    

    [myPlayer play];
    
    //[myPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork]; *ARTWORK*
    
    ViewController* vc = [[ViewController alloc] init];
    
    if (![[myPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle] length] == 0) {
        [vc speak:[NSString stringWithFormat:@"Now playing song: %@",[myPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle]]];
        
        EAResponseController* responseController = [EAResponseController sharedInstance];
        
        [responseController addMessage:[NSString stringWithFormat:@"Now playing song: %@",[myPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle]]];
        
    }
    else {
        EAResponseController* responseController = [EAResponseController sharedInstance];
        [responseController addMessage:@"No Match Found."];
        [vc speak:@"No Match Found"];
    }
    
    
    
    //[title release];
}

-(void)pause {
    MPMusicPlayerController* myPlayer = [MPMusicPlayerController iPodMusicPlayer];
    [myPlayer pause];
}



@end
