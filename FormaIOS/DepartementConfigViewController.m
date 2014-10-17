//
//  DepartementConfigViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//

#import "DepartementConfigViewController.h"
#import "FormaIOSAppDelegate.h"
#import "Departement.h"
#import "ConfigViewController.h"

@interface DepartementConfigViewController ()

@property (nonatomic, strong) FormaIOSAppDelegate *appDelegate ;
@property (nonatomic, weak) UITableViewCell *selectedCell ;
@property int nbCellules ;

@end

@implementation DepartementConfigViewController

@synthesize selectedCell ;
@synthesize nbCellules ;

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.deps = [[NSMutableArray alloc] initWithCapacity:3];
    [self.deps insertObject:@"DII_3A" atIndex:0];
    [self.deps insertObject:@"DII_4A" atIndex:1];
    [self.deps insertObject:@"DII_5A" atIndex:2];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)departementsMAJ {
   // [self.tableView reloadData] ;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"onDoneClick_event"])
    {
       
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.deps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellDepartement";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellAccessoryCheckmark reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [self.deps objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = NO ;
    if (cell != self.selectedCell) {
        self.selectedCell.accessoryType = UITableViewCellAccessoryNone ;
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
        self.selectedCell = cell ;
        cell.selected = NO ;
        self.appDelegate.prefsManager.departement = cell.textLabel.text ;
        [self.appDelegate.prefsManager sauvegarder] ;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    }
}

@end
