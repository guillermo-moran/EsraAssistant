//
//  EAImageData.m
//  ESRA
//
//  Created by Guillermo Moran on 5/21/12.
//  Copyright (c) 2012 Fr0st Development. All rights reserved.
//

#import "EAImageData.h"

@implementation EAImageData
@synthesize imageView,webView;

-(void)assignImage:(NSString*)url {
    //imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.barrettmotorcars.com/images/headlines/395/ferrari-f430-spider-1.jpg"]]];
    //imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    NSString *img = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('img')[0].src;"];
    NSLog(@"%@",img);
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    loadingView.hidden = NO;
    [loadingView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)web {
    NSString *img = [web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('img')[0].src;"];
    NSLog(@"Image URL: %@",img);
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img]]];
    [loadingView stopAnimating];
    loadingView.hidden = YES;
    
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
    webView.delegate = self;
    loadingView.hidden = YES;
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
