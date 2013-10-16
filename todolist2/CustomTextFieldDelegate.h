//
//  CustomTextFieldDelegate.h
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableTableViewController.h"

@interface CustomTextFieldDelegate : NSObject <UITextFieldDelegate>
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, weak) EditableTableViewController *tableViewController;

- (id) initWithRowIdAndTableViewController:(NSInteger)rowId tableViewControllerArg:(EditableTableViewController *)tableViewControllerArg;
- (void) setRowWithRow:(NSInteger)row;


@end
