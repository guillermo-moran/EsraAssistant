//
//  EAPlugin.h
//  ESRA
//
//  Created by Guillermo Moran on 7/16/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

@interface EAPlugin : NSObject 

-(void)load;
-(id)init;
-(NSString*)pluginResponse;
-(BOOL)isDataView;

@end
