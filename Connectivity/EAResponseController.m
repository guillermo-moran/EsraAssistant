//
//  EAResponseController.m
//  ESRA
//
//  Created by Guillermo Moran on 11/3/12.
//
//

#import <Foundation/Foundation.h>
#import "EAResponseController.h"
#import "EASpeaker.h"



@implementation EAResponseController
@synthesize messagesArray, cell;

static EAResponseController *sharedInstance = nil;


+ (EAResponseController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
            }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        // Magic.
        messagesArray = [[NSMutableArray alloc] init];
       tableController = [[ViewController alloc] init];
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
/*
- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

- (oneway void)release {
    
}

- (id)autorelease {
    return self;
}
*/
#pragma mark TableView

-(void)addMessage:(NSString*)message {
    /*
    if ([message hasPrefix:@"<"]) {
        return;
    }
    if ([message hasPrefix:@"OPEN_APP_WITH_URL: = "]) {
        return;
    }
    if ([message hasPrefix:@"RUN_COMMAND: "]) {
        return;
    }
    */
    
    
    NSLog(@"Adding message to table:%@",message);
    
    
    
    tableController.isDataView = NO;

    
    if ([message hasPrefix:@"\"<"] || [message hasPrefix:@"OPEN_APP_WITH_URL: = "] || [message hasPrefix:@"RUN_COMMAND: "] || [message hasSuffix:@"(null)"]) {
        
        return;
    }
    
    //if ([message hasPrefix:@"\n\n\n\n\n"]) {
     //   message = [message stringByReplacingOccurrencesOfString:@"\n\n\n\n\n\n" withString:@""];
    //}
    
    if ([message isEqualToString:@""]) {
        message = @"I don't know";
    }
    
    [messagesArray addObject:message];
        
    
    
    //NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[messagesArray count]-1 inSection:0];
    //[tableController.table insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TableDataChanged"
                                                        object:nil];
    
    NSLog(@"List of messages array: %@", self.messagesArray);
    
}


-(void)addData:(UIView*)view message:(NSString*)message {
 
     //if (!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
 
     tableController.isDataView = YES;
     [messagesArray addObject:@"\n\n\n\n\n\n\n\n"];
 
 
     dataView = view;
 
     [[NSNotificationCenter defaultCenter] postNotificationName:@"TableDataChanged"
                                                         object:nil];
    
 
 
 //}
 }
 

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [messagesArray count];
	
}

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 280.0f
#define CELL_CONTENT_MARGIN 20.0f

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return (rowHeight <= 1 ? 1 : rowHeight) * 15 + 40;
    //TableCells *cell = (TableCells *) [tableView dequeueReusableCellWithIdentifier:@"cellString"];
    
    
    
    NSString *text = [self.messagesArray objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)tableCell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableController.isDataView) {
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[messagesArray count]-1 inSection:0];
        
        if (indexPath.row == newIndexPath.row) {
            
            [tableCell.contentView addSubview:dataView];
        }
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellString = @"cell";
    
    
    cell = (TableCells *) [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil) {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"TableCells" owner:tableController options:nil];
        for (id currentObject in topLevelObject) {
            if ([currentObject isKindOfClass:[TableCells class]]) {
                cell = (TableCells *) currentObject;
                break;
            }
        }
    }
    
    cell.name.text = [messagesArray objectAtIndex:indexPath.row];
    
    
    //CELL RESIZING (EXPERIMENTAL)
    if (tableController.isResponse) cell.name.font = [UIFont boldSystemFontOfSize:14];
    else cell.name.font = [UIFont systemFontOfSize:14];
    
    CGRect frame = cell.name.frame;
    frame.size.height = cell.name.contentSize.height;
    //cell.bubbleIMG.frame = frame;
    cell.name.frame = frame;
    cell.frame = frame;
    int height = cell.name.contentSize.height;
    
    UIImageView* bubbleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bubble.png"]];
    
    
    bubbleView.frame = CGRectMake(10, 0, 310, height+15);
    [cell addSubview:bubbleView];
    [cell sendSubviewToBack:bubbleView];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (indexPath.row == 0) {
    }
    
    return cell;
}


@end