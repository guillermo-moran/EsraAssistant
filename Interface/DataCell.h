//
//  TableCells.h
//  ESRA
//
//  Created by Guillermo Moran on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataCell : UITableViewCell {
    
    IBOutlet UITextView *name;
    IBOutlet UIImageView *bubbleIMG; 
    
}
@property (nonatomic, strong) UITextView *name;
@property (nonatomic, strong) UIImageView* bubbleIMG;;


@property (nonatomic, strong) UIButton *DetailDiscloser;



@end

