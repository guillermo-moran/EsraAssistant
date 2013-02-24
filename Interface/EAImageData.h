//
//  EAImageData.h
//  ESRA
//
//  Created by Guillermo Moran on 5/21/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EAImageData : UIViewController <UIWebViewDelegate> {
    IBOutlet UIImageView* imageView;
    IBOutlet UIWebView* webView;
    IBOutlet UIActivityIndicatorView* loadingView;
}

-(void)assignImage:(NSString*)url;

@property(nonatomic, strong)IBOutlet UIImageView* imageView;
@property(nonatomic, strong)IBOutlet UIWebView* webView;

@end
