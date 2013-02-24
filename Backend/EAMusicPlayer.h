//
//  EAMusicPlayer.h
//  ESRA
//
//  Created by Guillermo Moran on 5/23/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface EAMusicPlayer : NSObject {
    
}

-(void)playSongWithTitle:(NSString*)title;
-(void)pause;

@end
