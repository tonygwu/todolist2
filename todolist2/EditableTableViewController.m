//
//  EditableTableViewController.m
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import "EditableTableViewController.h"
#import "EditableCell.h"
#import "CustomTextFieldDelegate.h"

@interface EditableTableViewController ()
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) NSMutableArray *textFieldDelegates;
@property (strong, nonatomic) UITapGestureRecognizer * gestureRecognizer;
@end

@implementation EditableTableViewController

@synthesize list = _list;
@synthesize textFieldDelegates = _textFieldDelegates;
@synthesize gestureRecognizer = _gestureRecognizer;

- (NSMutableArray *)list
{
    if (!_list)
    {
        _list = [[NSMutableArray alloc] init];
    }
    return _list;
}

- (NSMutableArray *)textFieldDelegates
{
    if (!_textFieldDelegates)
    {
        _textFieldDelegates = [[NSMutableArray alloc] init];
    }
    return _textFieldDelegates;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"To Do List";
    }
    return self;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    self.gestureRecognizer.enabled = !editing;
    [self.tableView setEditing:editing animated:animated];
    [super setEditing:editing animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneEditingText)];
    [self.tableView addGestureRecognizer:self.gestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
}

- (void) doneEditingText {
    [self.view endEditing:YES];
}

- (void) add
{
    UINib *customNib = [UINib nibWithNibName:@"EditableCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"EditableCell"];
    
    [self.list addObject:@""];
    [self.textFieldDelegates addObject:[[CustomTextFieldDelegate alloc] initWithRowIdAndTableViewController:self.textFieldDelegates.count tableViewControllerArg:self]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTextWithText:(NSString *)text forRow:(NSInteger)rowId {
    self.list[rowId] = text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditableCell";
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EditableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.taskTextField.text = self.list[indexPath.row];
    cell.taskTextField.delegate = self.textFieldDelegates[indexPath.row];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.list removeObjectAtIndex:indexPath.row];
        [self.textFieldDelegates removeObjectAtIndex:indexPath.row];
        for (long i = indexPath.row; i < self.textFieldDelegates.count; i++) {
            ((CustomTextFieldDelegate *)self.textFieldDelegates[i]).row = i;
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [self.list insertObject:@"" atIndex:indexPath.row];
        [self.textFieldDelegates insertObject:[[CustomTextFieldDelegate alloc] initWithRowIdAndTableViewController:self.textFieldDelegates.count tableViewControllerArg:self] atIndex:indexPath.row];
    }
    [self.tableView reloadData];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
