//
//  EditableTableViewController.m
//  todolist2
//
//  Created by Tony Wu on 10/16/13.
//  Copyright (c) 2013 Tony Wu. All rights reserved.
//

#import "EditableTableViewController.h"
#import "EditableCell.h"
#import "Constants.h"

@interface EditableTableViewController () <UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *list;
@end

@implementation EditableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = APP_TITLE;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.list = [[defaults stringArrayForKey:TODO_USER_DEFAULTS_KEY] mutableCopy];
        if (self.list) {
            NSLog(@"Reloading tableView from list: %@", self.list);
            [self.tableView reloadData];
        } else {
            NSLog(@"Initializing new list!");
            self.list = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [self.tableView setEditing:editing animated:animated];
    [super setEditing:editing animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.list[textField.tag] = textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:self.list forKey:TODO_USER_DEFAULTS_KEY];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // should i also write to defaults here?
    return NO;
}

- (void) add
{
    UINib *customNib = [UINib nibWithNibName:@"EditableCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"Cell"];
    
    [self.list addObject:@""];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditableCell" owner:self options:nil] objectAtIndex:0];
    }
    NSLog(@"cell is: %@", cell);
    NSLog(@"cell.taskTextField is: %@", cell.taskTextField);
    NSLog(@"list is: %@", self.list);
    NSLog(@"Configuring cell index %d: %@", indexPath.row, self.list[indexPath.row]);
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.taskTextField.text = self.list[indexPath.row];
    NSLog(@"taskTextField is: %@", cell.taskTextField.text);
    NSLog(@"cell.taskTextField is: %@", cell.taskTextField);
    cell.taskTextField.tag = indexPath.row;
    cell.taskTextField.delegate = self;
    [cell.taskTextField becomeFirstResponder];
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [self.list insertObject:@"" atIndex:indexPath.row];
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.list forKey:TODO_USER_DEFAULTS_KEY];
    [self.tableView reloadData];
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id tempObject = self.list[fromIndexPath.row];
    [self.list removeObjectAtIndex:fromIndexPath.row];
    [self.list insertObject:tempObject atIndex:toIndexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:self.list forKey:TODO_USER_DEFAULTS_KEY];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


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
