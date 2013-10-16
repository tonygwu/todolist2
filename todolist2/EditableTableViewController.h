//
//  EditableTableViewController.h
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableTableViewController : UITableViewController

- (void)setTextWithText:(NSString *)text forRow:(NSInteger)rowId;

@end
