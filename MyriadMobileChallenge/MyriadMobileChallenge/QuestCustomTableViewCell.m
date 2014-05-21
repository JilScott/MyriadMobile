//
//  QuestCustomTableViewCell.m
//  MyriadMobileChallenge
//
//  Created by Jackie Scott on 5/20/14.
//  Copyright (c) 2014 Jilian Scott. All rights reserved.
//

#import "QuestCustomTableViewCell.h"

@implementation QuestCustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
