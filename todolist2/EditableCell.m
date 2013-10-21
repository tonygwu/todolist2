//
//  EditableCell.m
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import "EditableCell.h"

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"taskTextField is: %@", self.taskTextField);
        [self.taskTextField becomeFirstResponder];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];
// you cannot select a cell
    // Configure the view for the selected state
}

@end
