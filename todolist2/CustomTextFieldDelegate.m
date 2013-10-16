//
//  CustomTextFieldDelegate.m
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import "CustomTextFieldDelegate.h"
#import "EditableTableViewController.h"

@interface CustomTextFieldDelegate()
@end

@implementation CustomTextFieldDelegate

@synthesize row = _row;
@synthesize tableViewController = _tableViewController;

- (id) initWithRowIdAndTableViewController:(NSInteger)rowId tableViewControllerArg:(EditableTableViewController *)tableViewControllerArg
{
    self = [super init];
    if (self != nil) {
        self.row = rowId;
        self.tableViewController = tableViewControllerArg;
    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.tableViewController setTextWithText:textField.text forRow:self.row];
}

@end
