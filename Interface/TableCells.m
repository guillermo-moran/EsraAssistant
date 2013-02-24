//
//  TableCells.m
//  ESRA
//
//  Created by Guillermo Moran on 11/26/11.
//  Copyright (c) 2011 Fr0st Development. All rights reserved.
//

#import "TableCells.h"

@implementation TableCells
@synthesize name,DetailDiscloser,bubbleIMG;

-(void)insertData:(UIView *)view {
    UIView* dataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 150)];
    [self.contentView addSubview:dataView];
    //dataView = view;
    [dataView addSubview:view];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
