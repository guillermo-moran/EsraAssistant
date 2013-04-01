//
//  EAApplicationController.m
//  ESRA
//
//  Created by Guillermo Moran on 3/2/13.
//
//

#import "EAApplicationController.h"

@implementation EAApplicationController

-(NSDictionary*)applications {
    //NSDictionary *options = [NSDictionary dictionaryWithKeysAndValues:@"ApplicationType",@"Any",nil];
    //NSDictionary *apps = MobileInstallationLookup(options);
    
    NSError *fError = nil;
    
	NSArray *shits = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/" error:&fError];
    
    //	if (fError) return;
    
	NSMutableDictionary *allApps = [[NSMutableDictionary alloc] init];
    
	for (NSString *_shit in shits) {
        
		NSError *rError = nil;
        
		NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"/User/Applications/%@/", _shit] error:&rError];
        
        //		if (rError) return;
        
		for (NSString *_item in contents) {
            
			if ([_item hasSuffix:@"app"]) {
                
				NSDictionary *bd = [[NSDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Applications/%@/%@/Info.plist", _shit, _item]];
                
				//[allApps setObject:[NSString stringWithFormat:@"/User/Applications/%@/%@/%@", _shit, _item, [bd objectForKey:@"CFBundleExecutable"]] forKey:[bd objectForKey:@"CFBundleIdentifier"]];
                
                NSString* dispName;
                dispName = [bd objectForKey:@"CFBundleDisplayName"];
                
                if (dispName == nil) {
                    dispName = [bd objectForKey:@"CFBundleName"];
                }
                
                NSString* identifier = [bd objectForKey:@"CFBundleIdentifier"];
                
                [allApps setObject:identifier forKey:[dispName lowercaseString]];
            
                
				//[bd release];
			}
		}
	}
    
	NSArray *bigShits = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Applications/" error:&fError];
    
    //	if (fError) return;
    
	if (fError) NSLog(@"errrrrrr %@", fError);
    
	for (NSString *_app in bigShits) {
        
		if ([_app hasSuffix:@"app"]) {
            
			NSDictionary *abd = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/Applications/%@/Info.plist", _app]];
            
			// if created using alloc/init, crash. no idea why. so just use this. it's autoreleased.
			
            if (! abd) {
                continue;
            }
            
			if ([abd objectForKey:@"CFBundleIdentifier"]) {
                
				//[allApps setObject:[NSString stringWithFormat:@"/Applications/%@/%@", _app, [abd objectForKey:@"CFBundleExecutable"]] forKey:[abd objectForKey:@"CFBundleIdentifier"]];
            
                NSString* dispName;
                dispName = [abd objectForKey:@"CFBundleDisplayName"];
                
                if (dispName == nil) {
                    
                    dispName = [abd objectForKey:@"CFBundleExecutable"];
                    
                }
                
                
                NSString* identifier = [abd objectForKey:@"CFBundleIdentifier"];
                
                
            
                [allApps setObject:identifier forKey:[dispName lowercaseString]];
            }
            
            // Adsheet.app has no CFBundleIdentifier god knows why.
		}
	}
	return allApps;
    
	//release allapps or else.
    
}

-(void)openApplicationWithName:(NSString*)name {
    
    NSString* identifier = [[self applications] objectForKey:name];
    
    [[UIApplication sharedApplication] launchApplicationWithIdentifier:identifier suspended:NO];
}



@end
