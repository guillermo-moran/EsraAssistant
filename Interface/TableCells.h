//
//  TableCells.h
//  ESRA
//
//  Created by Guillermo Moran on 11/26/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCells : UITableViewCell {
    
    IBOutlet UITextView *name;
    IBOutlet UIImageView *bubbleIMG; 
    
}
@property (nonatomic, strong) UITextView *name;
@property (nonatomic, strong) UIImageView* bubbleIMG;;


@property (nonatomic, strong) UIButton *DetailDiscloser;

-(void)insertData:(UIView*)view;

@end

