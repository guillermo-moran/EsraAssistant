//
//  EAResponseController.h
//  ESRA
//
//  Created by Guillermo Moran on 11/3/12.
//
//

#import <Foundation/Foundation.h>
#import "TableCells.h"
#import "ViewController.h"

@interface EAResponseController : NSObject <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray* messagesArray;
    ViewController* tableController;
    UIView* dataView;
    
}

+(id)sharedInstance;

-(void)addMessage:(NSString*)message;
-(void)addData:(UIView*)view message:(NSString*)message;

@property (nonatomic, copy) NSMutableArray* messagesArray;
@property (nonatomic,strong) TableCells* cell;

@end
