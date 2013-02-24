//
//  VSSpeechSynthesizer.h
//  repeat
//
//  Created by Guillermo Moran on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface VSSpeechSynthesizer : NSObject {
}
+(id)availableVoices;
+(id)availableVoicesForLanguageCode:(id)languageCode;
+(id)availableLanguageCodes;
+(BOOL)isSystemSpeaking;
+(void)_localeDidChange;
-(id)init;
-(id)initForInputFeedback;
-(void)dealloc;
-(void)setDelegate:(id)delegate;
-(id)startSpeakingString:(id)string;
-(id)startSpeakingString:(id)string toURL:(id)url;
-(id)startSpeakingString:(id)string attributedString:(id)string2 toURL:(id)url withLanguageCode:(id)languageCode;
-(id)startSpeakingString:(id)string toURL:(id)url withLanguageCode:(id)languageCode;
-(id)startSpeakingAttributedString:(id)string;
-(id)startSpeakingAttributedString:(id)string toURL:(id)url;
-(id)startSpeakingAttributedString:(id)string toURL:(id)url withLanguageCode:(id)languageCode;
-(id)stopSpeakingAtNextBoundary:(int)nextBoundary;
-(id)stopSpeakingAtNextBoundary:(int)nextBoundary synchronously:(BOOL)synchronously;
-(id)pauseSpeakingAtNextBoundary:(int)nextBoundary;
-(id)pauseSpeakingAtNextBoundary:(int)nextBoundary synchronously:(BOOL)synchronously;
-(id)continueSpeaking;
-(BOOL)isSpeaking;
-(id)speechString;
-(float)rate;
-(id)setRate:(float)rate;
-(float)minimumRate;
-(float)maximumRate;
-(id)setPitch:(float)pitch;
-(float)pitch;
-(id)setVolume:(float)volume;
-(float)volume;
-(void)setVoice:(id)voice;
-(id)voice;
-(void)setMaintainPersistentConnection:(BOOL)connection;
@end
