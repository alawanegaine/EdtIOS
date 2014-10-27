//
//  EtablissementConfigViewController.m
//  FormaIOS
//
//  Created by Jean-Baptiste Martin on 13/12/12.
//  Copyright (c) 2012 Jean-Baptiste Martin. All rights reserved.
//
//

#import "EtablissementConfigViewController.h"
#import "Etablissement.h"
#import "EtablissementFetcher.h"
#import "FormaIOSAppDelegate.h"
#import "ConfigViewController.h"

@interface EtablissementConfigViewController()

@property (nonatomic, readonly) FormaIOSAppDelegate *appDelegate ;
@property (nonatomic, weak) UITableViewCell *selectedCell ;

@end

@implementation EtablissementConfigViewController

- (FormaIOSAppDelegate*)appDelegate {
    return [[UIApplication sharedApplication] delegate] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.etabs = [[NSArray alloc] init];
    self.etabs = [EtablissementFetcher fetch];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.etabs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellEtablissement";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    self.dictionary = [self.etabs objectAtIndex:indexPath.row]; // on va chercher le dictionnaire au bon index
    if ([[self.dictionary objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = @" " ;
    }
    else{
         cell.textLabel.text = [ self.dictionary objectForKey:@"name"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.selected = NO ;
    if (cell != self.selectedCell) {
        self.selectedCell.accessoryType = UITableViewCellAccessoryNone ;
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
        self.selectedCell = cell ;
        cell.selected = NO ;
        self.appDelegate.prefsManager.etablissement = cell.textLabel.text ;
        [self.appDelegate.prefsManager sauvegarder] ;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blueColor]];
        [self.navigationItem.rightBarButtonItem setEnabled:true];
    }
}

@end
